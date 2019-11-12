//
//  LandingPageTemplate.m
//  react-native-nativo-ads
//
//  Created by Matthew Murray on 11/12/19.
//

#import "LandingPageTemplate.h"
#import "NativoAdsUtils.h"
#import <React/UIView+React.h>
#import <React/RCTUIManager.h>

@implementation LandingPageTemplate

- (WKWebView *)contentWKWebView {
    if (self.rootView) {
        UIView *webView = [self.rootView.bridge.uiManager viewForNativeID:@"" withRootTag:self.rootView.reactTag];
        webView = [NativoAdsUtils findClass:[WKWebView class] inView:webView];
        if (webView) {
            return (WKWebView *)webView;
        }
    }
    return nil;
}

- (UIImageView *)previewImageView {
    if (self.rootView) {
        UIView *previewImageView = [self.rootView.bridge.uiManager viewForNativeID:@"articleImage" withRootTag:self.rootView.reactTag];
        if (previewImageView) {
            return (UIImageView *)previewImageView;
        }
    }
    return nil;
}

- (UIImageView *)authorImageView {
    if (self.rootView) {
        UIView *authorImageView = [self.rootView.bridge.uiManager viewForNativeID:@"authorImage" withRootTag:self.rootView.reactTag];
        if (authorImageView) {
            return (UIImageView *)authorImageView;
        }
    }
    return nil;
}

- (void)handleExternalLink:(nonnull NSURL *)link {
    
}

@end
