//
//  FakeLandingPage.m
//  react-native-nativo-ads
//
//  Created by Matt Murray on 1/8/20.
//

#import "NativoLandingPageTemplate.h"
#import <React/RCTUtils.h>

@interface NativoLandingPageTemplate ()

@end

@implementation NativoLandingPageTemplate

- (WKWebView *)contentWKWebView {
    return self.webView;
}

- (void)didLoadContentWithAd:(nonnull NtvAdData *)adData {
    self.adData = adData;
}

- (BOOL)contentWebViewShouldScroll {
    return self.shouldScroll;
}

- (void)setContentWebViewHeight:(CGFloat)contentHeight {
    if (!self.shouldScroll) {
        if (self.onFinishLoading) {
            self.onFinishLoading(@{ @"contentHeight" : @(contentHeight) } );
        }
    }
}

- (void)handleExternalLink:(nonnull NSURL *)link {
    if (self.onClickExternalLink) {
        self.onClickExternalLink(@{ @"url" : link.absoluteString });
    }
}

- (void)contentWebViewDidFinishLoad {
    if (self.shouldScroll) {
        if (self.onFinishLoading) {
            self.onFinishLoading(@{ @"contentHeight" : @(self.webView.frame.size.height) });
        }
    }
}

- (void)contentWebViewDidFailLoadWithError:(nullable NSError *)error {
    if (self.onFinishLoading) {
        NSDictionary *rctError = RCTMakeError(error.description, error, nil);
        self.onFinishLoading(@{ @"error" : rctError,
                        @"contentHeight" : @(self.webView.frame.size.height) });
    }
}

@end
