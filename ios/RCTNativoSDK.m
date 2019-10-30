//
//  RCTNativoSDK.m
//  NativoAds
//
//  Created by Matthew Murray on 10/22/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTNativoSDK.h"
#import "RCTNtvSectionDelegate.h"
#import <React/RCTLog.h>
#import <NativoSDK/NativoSDK.h>

@interface RCTNativoSDK ()

@end

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
    [NativoSDK setSectionDelegate:[RCTNtvSectionDelegate sharedInstance] forSection:section];
    [NativoSDK prefetchAdForSection:section atLocationIdentifier:identifier options:nil];
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
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
