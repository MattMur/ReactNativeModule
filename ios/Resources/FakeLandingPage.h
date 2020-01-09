//
//  FakeLandingPage.h
//  react-native-nativo-ads
//
//  Created by Matt Murray on 1/8/20.
//

#import <UIKit/UIKit.h>
#import <NativoSDK/NativoSDK.h>

NS_ASSUME_NONNULL_BEGIN

/*
 Used only to trick the NativoSDK into sending section delegate method 'shouldDisplayLandingPage'
 */
@interface FakeLandingPage : UIViewController <NtvLandingPageInterface>

@end

NS_ASSUME_NONNULL_END
