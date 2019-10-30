//
//  RCTNtvSectionDelegate.m
//  NativoAds
//
//  Created by Matthew Murray on 10/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTNtvSectionDelegate.h"

@implementation RCTNtvSectionDelegate

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static RCTNtvSectionDelegate *sharedDelegate;
    dispatch_once(&once, ^{
        sharedDelegate = [[RCTNtvSectionDelegate alloc] init];
        [RCTNtvSectionDelegate initializeSDK];
    });
    return sharedDelegate;
}

+ (void)initializeSDK {
    NSString *ntvBundlePath = [[NSBundle mainBundle] pathForResource:@"NativoAds" ofType:@"bundle"];
    NSBundle *ntvBundle = [NSBundle bundleWithPath:ntvBundlePath];
    NSError *error;
    [ntvBundle loadAndReturnError:&error];
    [NativoSDK registerNib:[UINib nibWithNibName:@"ArticleNativeAdView" bundle:ntvBundle] forAdTemplateType:NtvAdTemplateTypeNative];
    [NativoSDK registerNib:[UINib nibWithNibName:@"ArticleVideoAdView" bundle:ntvBundle] forAdTemplateType:NtvAdTemplateTypeVideo];
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
}

- (void)section:(NSString *)sectionUrl requestDidFailWithError:(nullable NSError *)error {
    NSLog(@"%@ Ad did fail with error: %@", sectionUrl, error);
}

@end
