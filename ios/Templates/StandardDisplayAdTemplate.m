//
//  StandardDisplayAdTemplate.m
//  react-native-nativo-ads
//
//  Created by Matthew Murray on 12/10/19.
//

#import "StandardDisplayAdTemplate.h"

@implementation StandardDisplayAdTemplate

- (NtvContentWebView *)contentWebView {
    if (!_contentWebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _contentWebView = [[NtvContentWebView alloc] initWithFrame:self.bounds configuration:config];
        [self addSubview:_contentWebView];
        
        // Set X Axis
        [_contentWebView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0].active = YES;

        // Set Y Axis
        [self.topAnchor constraintEqualToAnchor:_contentWebView.topAnchor constant:-20].active = YES;
        [self.bottomAnchor constraintEqualToAnchor:_contentWebView.bottomAnchor constant:20].active = YES;
    }
    return _contentWebView;
}

@end
