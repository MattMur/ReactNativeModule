//
//  RCTNtvSectionDelegate.h
//  NativoAds
//
//  Created by Matthew Murray on 10/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NativoSDK/NativoSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTNtvSectionDelegate : NSObject <NtvSectionDelegate>

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
