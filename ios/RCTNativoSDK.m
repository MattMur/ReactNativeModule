//
//  RCTNativoSDK.m
//  NativoAds
//
//  Created by Matthew Murray on 10/22/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTNativoSDK.h"
#import "NtvSharedSectionDelegate.h"
#import "LandingPageTemplate.h"
#import <React/RCTLog.h>
#import <React/UIView+React.h>
#import <React/RCTUIManager.h>
#import <React/RCTLog.h>
#import <NativoSDK/NativoSDK.h>
#import <objc/runtime.h>


@implementation RCTNativoSDK

RCT_EXPORT_MODULE(NativoSDK);

RCT_EXPORT_METHOD(enableDevLogs)
{
    [NativoSDK enableDevLogs];
}

RCT_EXPORT_METHOD(enableTestAdvertisements)
{
    [NativoSDK enableTestAdvertisements];
}

RCT_EXPORT_METHOD(enableTestAdvertisementsWithType:(nonnull NSNumber *)adType)
{
    [NativoSDK enableTestAdvertisementsWithAdType:[adType intValue]];
}

RCT_EXPORT_METHOD(prefetchAdForSection:(NSString *)section atLocationIdentifier:(NSString *)identifier)
{
    [NativoSDK setSectionDelegate:[NtvSharedSectionDelegate sharedInstance] forSection:section];
    [NativoSDK prefetchAdForSection:section atLocationIdentifier:identifier options:nil];
}

RCT_EXPORT_METHOD(injectLandingPage:(id)reactTag inSection:(NSString *)section atLocationIdentifier:(id)identifier  shouldScroll:(BOOL)shouldScroll)
{
    if (self.bridge) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.bridge.uiManager rootViewForReactTag:reactTag withCompletion:^(UIView *rootView) {
                if (rootView) {
                    __weak RCTNativoSDK *weakSelf = self;
                    LandingPageTemplate *landingPageProxy = [[LandingPageTemplate alloc] init];
                    landingPageProxy.rootView = (RCTRootView *)rootView;
                    landingPageProxy.shouldScroll = shouldScroll;
                    landingPageProxy.handleEvent = ^(NSString * _Nonnull eventName, NSDictionary * _Nullable response) {
                        [weakSelf sendEventWithName:eventName body:response];
                    };
                    NSString *locStr = [NSString stringWithFormat:@"%@", identifier];
                    [NativoSDK injectSponsoredLandingPageViewController:landingPageProxy forSection:section withAdAtLocationIdentifier:locStr];
                    
                    // Set associated object to link to root view's retain cycle
                    objc_setAssociatedObject(rootView, @selector(contentWKWebView), landingPageProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                }
            }];
        });
    }
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"landingPageHandleExternalLink", @"landingPageDidFinishLoading"];
}

- (NSDictionary *)constantsToExport
{
    NSDictionary *adTypes = @{ @"NATIVE" : @(NtvTestAdTypeNative),
                               @"DISPLAY" : @(NtvTestAdTypeDisplay),
                               @"CLICK_VIDEO" : @(NtvTestAdTypeClickToPlayVideo),
                               @"SCROLL_VIDEO" : @(NtvTestAdTypeScrollToPlayVideo),
                               @"NO_FILL" : @(NtvTestAdTypeNoFill) };
    return @{ @"AdTypes" : adTypes };
};

@end
