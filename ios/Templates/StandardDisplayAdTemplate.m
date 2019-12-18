//
//  StandardDisplayAdTemplate.m
//  react-native-nativo-ads
//
//  Created by Matthew Murray on 12/10/19.
//

#import "StandardDisplayAdTemplate.h"
#import <React/UIView+React.h>
#import <React/RCTUIManager.h>
#import <React/RCTUIManagerUtils.h>
#import <React/RCTView.h>
#import <objc/runtime.h>

#define CONTAINER_TAG @"nativoAdWebView"

@implementation StandardDisplayAdTemplate

- (NtvContentWebView *)contentWebView {
    if (!_contentWebView) {
        RCTView *webContainer = (RCTView *)[self.bridge.uiManager viewForNativeID:CONTAINER_TAG withRootTag:self.reactTag];
        if (webContainer) {
            webContainer.accessibilityLabel = @"Display Container";
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            _contentWebView = [[NtvContentWebView alloc] initWithFrame:webContainer.bounds configuration:config];
            [webContainer addSubview:_contentWebView];

            // Constraint to edges
            [_contentWebView.leftAnchor constraintEqualToAnchor:webContainer.leftAnchor].active = YES;
            [_contentWebView.rightAnchor constraintEqualToAnchor:webContainer.rightAnchor].active = YES;
            [_contentWebView.topAnchor constraintEqualToAnchor:webContainer.topAnchor].active = YES;
            [_contentWebView.bottomAnchor constraintEqualToAnchor:webContainer.bottomAnchor].active = YES;
        } else {
            NSLog(@"Could not find view with nativeID: %@ to inject standard display content into.", CONTAINER_TAG);
        }
    }
    return _contentWebView;
}

- (void)didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"DidFinishNavigation");
//    CGSize contentSize = _contentWebView.intrinsicContentSize;
//    RCTView *webContainer = (RCTView *)[self.bridge.uiManager viewForNativeID:CONTAINER_TAG withRootTag:self.reactTag];
//    if (webContainer) {
//        [self.bridge.uiManager setSize:contentSize forView:webContainer];
//    }
}

- (void)didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error {
    NSLog(@"Did fail: %@", error);
}

@end
