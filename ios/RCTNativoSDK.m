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
#import <React/RCTUIManagerUtils.h>
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

RCT_EXPORT_METHOD(loadSponsoredContent:(id)reactTag inSection:(NSString *)section atLocationIdentifier:(id)identifier  shouldScroll:(BOOL)shouldScroll)
{
//    if (self.bridge) {
//        
//        RCTExecuteOnUIManagerQueue(^{
//            [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
//                UIView *rootWebView = viewRegistry[reactTag];
//                if (rootWebView) {
//                    __weak RCTNativoSDK *weakSelf = self;
//                    LandingPageTemplate *landingPageProxy = [[LandingPageTemplate alloc] init];
//                    landingPageProxy.bridge = self.bridge;
//                    landingPageProxy.rootWebView = (RCTView *)rootWebView;
//                    landingPageProxy.shouldScroll = shouldScroll;
//                    landingPageProxy.handleEvent = ^(NSString * _Nonnull eventName, NSDictionary * _Nullable response) {
//                        [weakSelf sendEventWithName:eventName body:response];
//                    };
//                    [NativoSDK injectSponsoredLandingPageViewController:landingPageProxy forSection:section withAdAtLocationIdentifier:identifier];
//                    
//                    // Set associated object to link to root view's retain cycle
//                    objc_setAssociatedObject(rootWebView, @selector(contentWKWebView), landingPageProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//                }
//            }];
//        });
//    }
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
                               @"STANDARD_DISPLAY" : @(NtvTestAdTypeStandardDisplay),
                               @"DISPLAY_ADCHOICES" : @(NtvTestAdTypeAdChoicesDisplay),
                               @"CLICK_VIDEO_ADCHOICES" : @(NtvTestAdTypeAdChoicesVideo),
                               @"NO_FILL" : @(NtvTestAdTypeNoFill) };
    return @{ @"AdTypes" : adTypes };
};

@end
