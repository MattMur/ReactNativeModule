//
//  RCTNtvSectionDelegate.m
//  NativoAds
//
//  Created by Matthew Murray on 10/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "NtvSharedSectionDelegate.h"
#import "NativoAds.h"
#import <NativoSDK/NativoSDK.h>

@interface NtvSharedSectionDelegate ()
@property (nonatomic) NSMutableDictionary<NSString *, NSMutableDictionary<id, NativoAd*>*> *viewMap;
@end

@implementation NtvSharedSectionDelegate

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static NtvSharedSectionDelegate *sharedDelegate;
    dispatch_once(&once, ^{
        sharedDelegate = [[NtvSharedSectionDelegate alloc] init];
        sharedDelegate.viewMap = [NSMutableDictionary dictionary];
    });
    return sharedDelegate;
}

// Cache NativoAd for later when we have ad data
+ (void)setAdView:(NativoAd *)nativoAdView forSectionUrl:(NSString *)sectionUrl atLocationIdentifier:(id)locationId {
    [NativoSDK setSectionDelegate:[NtvSharedSectionDelegate sharedInstance] forSection:sectionUrl];
    NSMutableDictionary *sectionMap = [NtvSharedSectionDelegate sharedInstance].viewMap;
    if (sectionUrl && locationId) {
        NSMutableDictionary *viewMap = sectionMap[sectionUrl];
        if (viewMap) {
            viewMap[locationId] = nativoAdView;
        } else {
            viewMap = [@{ locationId : nativoAdView } mutableCopy];
            sectionMap[sectionUrl] = viewMap;
        }
    }
}

- (void)section:(NSString *)sectionUrl needsReloadDatasourceAtLocationIdentifier:(id)identifier forReason:(NSString *)reason {
    NSLog(@"%@ %@", sectionUrl, reason);
}

- (void)section:(NSString *)sectionUrl needsDisplayLandingPage:(nullable UIViewController<NtvLandingPageInterface> *)sponsoredLandingPageViewController {
    NSLog(@"%@ Attempting to display Nativo Landing Page", sectionUrl);
}

- (void)section:(NSString *)sectionUrl needsDisplayClickoutURL:(NSURL *)url {
    NSLog(@"%@ Attempting to display Nativo Clickout URL: %@", sectionUrl, url);
}

- (void)section:(NSString *)sectionUrl didReceiveAd:(NtvAdData *)adData {
    NSLog(@"%@ Did recieve Ad!", sectionUrl);
    NSMutableDictionary *sectionMap = [NtvSharedSectionDelegate sharedInstance].viewMap;
    NSDictionary *viewMap = sectionMap[sectionUrl];
    if (viewMap && adData) {
        NativoAd *adView = viewMap[adData.locationIdentifier];
        [adView injectWithAdData:adData];
    }
}

- (void)section:(NSString *)sectionUrl requestDidFailWithError:(nullable NSError *)error {
    NSLog(@"%@ Ad did fail with error: %@", sectionUrl, error);
}

/*
 + (void)initializeSDK {
     NSString *ntvBundlePath = [[NSBundle mainBundle] pathForResource:@"NativoAds" ofType:@"bundle"];
     NSBundle *ntvBundle = [NSBundle bundleWithPath:ntvBundlePath];
     NSError *error;
     [ntvBundle loadAndReturnError:&error];
     [NativoSDK registerNib:[UINib nibWithNibName:@"ArticleNativeAdView" bundle:ntvBundle] forAdTemplateType:NtvAdTemplateTypeNative];
     [NativoSDK registerNib:[UINib nibWithNibName:@"ArticleVideoAdView" bundle:ntvBundle] forAdTemplateType:NtvAdTemplateTypeVideo];
 }
 */

@end
