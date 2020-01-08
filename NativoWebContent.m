
#import "NativoWebContent.h"
#import <NativoSDK/NativoSDK.h>
#import <React/RCTLog.h>

@implementation NativoWebContentManager

RCT_EXPORT_MODULE(NativoWebContent)
RCT_EXPORT_VIEW_PROPERTY(sectionUrl, NSString)
RCT_EXPORT_VIEW_PROPERTY(locationId, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(shouldScroll, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onFinishLoading, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onClickExternalLink, RCTBubblingEventBlock)

- (UIView *)view
{
    NativoWebContentView *webContentView = [[NativoWebContentView alloc] init];
    return webContentView;
}

@end


@implementation NativoWebContentView

- (void)didMoveToSuperview {
    
    if (!self.nativoWebView) {
        self.nativoWebView = [[NtvContentWebView alloc] initWithFrame:self.bounds configuration:[[WKWebViewConfiguration alloc] init]];
        //self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.nativoWebView];
        [self.nativoWebView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [self.nativoWebView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [self.nativoWebView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [self.nativoWebView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    }
    
    // This part used only for landing pages
    if (self.sectionUrl && self.locationId) {
        self.templateProxy = [[LandingPageTemplate alloc] init];
        self.templateProxy.webView = self.nativoWebView;
        self.templateProxy.shouldScroll = self.shouldScroll;
        self.templateProxy.onClickExternalLink = self.onClickExternalLink;
        self.templateProxy.onFinishLoading = self.onFinishLoading;
        [NativoSDK injectSponsoredLandingPageViewController:self.templateProxy forSection:self.sectionUrl withAdAtLocationIdentifier:self.locationId];
    }
}

@end
