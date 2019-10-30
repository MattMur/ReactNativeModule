//
//  NativoAdsUtils.h
//  NativoAds
//
//  Created by Matthew Murray on 10/2/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NativoAdsUtils : NSObject

+ (NSString *)getBundleId;
+ (NSString *)getAppVersion;
+ (void)saveToUserDefaults:(NSObject *)myString key:(NSString *)myKey;
+ (NSObject *)retrieveFromUserDefaults:(NSString *)myKey;
+ (void)removeFromUserDefaults:(NSString *)myKey;
+ (UIScrollView *)getParentScrollViewForView:(UIView *)view;
+ (UIView *)findTopMostViewBeforeScrollViewForView:(UIView *)view;
+ (UIView *)findClass:(Class)class inView:(UIView *)view;
+ (UIView *)findClass:(Class)class inSuperViews:(UIView *)view;
+ (UIView *)getContentViewForCell:(UIView *)cell;
+ (BOOL)view:(UIView *)subview isSubviewOfView:(UIView *)parentView;
+ (BOOL)frameIsMinimumViewable:(CGRect)frame inContainer:(CGRect)container minPercentViewable:(float)minViewable;

@end

NS_ASSUME_NONNULL_END
