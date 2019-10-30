//
//  NativoAdsUtils.m
//  NativoAds
//
//  Created by Matthew Murray on 10/2/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "NativoAdsUtils.h"

@implementation NativoAdsUtils

+ (NSString *)getBundleId {
    return [[NSBundle mainBundle] bundleIdentifier];

}

+ (NSString *)getAppVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(void)saveToUserDefaults:(NSObject*)myObject key:(NSString*)myKey{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myObject forKey:myKey];
    }
}

+(NSObject*)retrieveFromUserDefaults:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSObject *val = nil;
    
    if (standardUserDefaults){
        val = [standardUserDefaults objectForKey:myKey];
    }
    
    return val;
}

+(void)removeFromUserDefaults:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults removeObjectForKey:myKey];
    }
}


+ (UIScrollView *)getParentScrollViewForView:(UIView *)view
{
    // Iterate through superviews until we find an active scrollview or the outermost container
    UIView *container = view;
    while ((![container isKindOfClass:[UIScrollView class]] || [container.superview isKindOfClass:[UIScrollView class]]) && container != nil) {
        container = container.superview;
    }
    return (UIScrollView *)container;
}

+ (UIView *)findTopMostViewBeforeScrollViewForView:(UIView *)view {
    UIView *container = view;
    while (container.superview != nil && ![container.superview isKindOfClass:[UIScrollView class]]) {
        container = container.superview;
    }
    return container;
}

+ (UIView *)findClass:(Class)class inView:(UIView *)view {
    //NSLog(@"View: %@ has #%lu subviews", view, (unsigned long)view.subviews.count);
    UIView *viewFound = nil;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:class]) {
            viewFound = subView;
        } else {
            viewFound = [self findClass:class inView:subView];
        }
    }
    return viewFound;
}

+ (UIView *)findClass:(Class)class inSuperViews:(UIView *)view {
    UIView *viewFound = view;
    while (viewFound.superview != nil && ![viewFound.superview isKindOfClass:class]) {
        viewFound = viewFound.superview;
    }
    return viewFound.superview;
}

+ (BOOL)view:(UIView *)subview isSubviewOfView:(UIView *)parentView {
    UIView *nextView = subview;
    while (nextView.superview != nil && nextView != parentView) {
        nextView = nextView.superview;
    }
    return nextView == parentView;
}


+ (BOOL)frameIsMinimumViewable:(CGRect)frame inContainer:(CGRect)container minPercentViewable:(float)minViewable {
    float area = frame.size.height * frame.size.width;
    float minimumArea = area * minViewable;
    CGRect visibleRect = CGRectIntersection(frame, container);
    CGFloat visibleArea = visibleRect.size.height * visibleRect.size.width;
    return visibleArea > minimumArea;
}

// Also remove cell from superview
+ (UIView *)getContentViewForCell:(UIView *)cell {
    if ([cell isKindOfClass:[UITableViewCell class]]) {
        //[cell removeFromSuperview];
        return ((UITableViewCell *)cell).contentView;
    } else if ([cell isKindOfClass:[UICollectionViewCell class]]) {
        //[cell removeFromSuperview];
        return ((UICollectionViewCell *)cell).contentView;
    } else {
        return cell;
    }
}

@end
