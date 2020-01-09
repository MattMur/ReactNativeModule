//
//  LandingPageTemplate.h
//  react-native-nativo-ads
//
//  Created by Matthew Murray on 11/12/19.
//

#import <React/RCTView.h>
#import <React/RCTBridge.h>
#import <NativoSDK/NativoSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NtvEventHandleBlock)(NSString *eventName,  id _Nullable response);

@interface LandingPageTemplate : UIViewController <NtvLandingPageInterface>

@property (nonatomic) WKWebView *webView;
@property (nonatomic) BOOL shouldScroll;
@property (nonatomic) RCTBubblingEventBlock onFinishLoading;
@property (nonatomic) RCTBubblingEventBlock onClickExternalLink;
@property (nonatomic) NtvAdData *adData;

@end

NS_ASSUME_NONNULL_END
