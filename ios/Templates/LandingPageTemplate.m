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
#import <React/RCTUtils.h>

@implementation LandingPageTemplate

- (WKWebView *)contentWKWebView {
    if (!_webView) {
        if (self.rootView) {
            self.rootWebView = [self.rootView.bridge.uiManager viewForNativeID:@"nativoAdWebView" withRootTag:self.rootView.reactTag];
            self.webView = (WKWebView *)[NativoAdsUtils findClass:[WKWebView class] inView:self.rootWebView];
            if (!self.webView) {
                RCTLogError(@"Couldn't find WKWebView in root view with tag: %@ using nativeID: nativoAdWebView", self.rootView.reactTag);
            }
        }
    }
    return self.webView;
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

- (BOOL)contentWebViewShouldScroll {
    return self.shouldScroll;
}

- (void)setContentWebViewHeight:(CGFloat)contentHeight {
    if (!self.shouldScroll) {
        if (self.handleEvent) {
            self.handleEvent(@"landingPageDidFinishLoading", @{ @"contentHeight" : @(contentHeight) } );
        }
    }
}

- (void)handleExternalLink:(nonnull NSURL *)link {
    if (self.handleEvent) {
        self.handleEvent(@"landingPageHandleExternalLink", @{ @"url" : link.absoluteString });
    }
}

- (void)contentWebViewDidFinishLoad {
    if (self.shouldScroll) {
        if (self.handleEvent) {
            self.handleEvent(@"landingPageDidFinishLoading",
                             @{ @"contentHeight" : @(self.rootWebView.frame.size.height) });
        }
    }
}

- (void)contentWebViewDidFailLoadWithError:(nullable NSError *)error {
    if (self.handleEvent) {
        NSDictionary *rctError = RCTMakeError(error.description, error, nil);
        self.handleEvent(@"landingPageDidFinishLoading",
                         @{ @"error" : rctError,
                    @"contentHeight" : @(self.rootWebView.frame.size.height) });
    }
}

@end
