//
//  StandardDisplayAdTemplate.h
//  react-native-nativo-ads
//
//  Created by Matthew Murray on 12/10/19.
//

#import "RCTRootView.h"
#import <NativoSDK/NativoSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface StandardDisplayAdTemplate : RCTRootView <NtvStandardDisplayAdInterface>

@property (nonatomic) NtvContentWebView *contentWebView;

@end

NS_ASSUME_NONNULL_END
