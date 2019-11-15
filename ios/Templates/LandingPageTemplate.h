//
//  LandingPageTemplate.h
//  react-native-nativo-ads
//
//  Created by Matthew Murray on 11/12/19.
//

#import <React/RCTRootView.h>
#import <NativoSDK/NativoSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NtvEventHandleBlock)(NSString *eventName,  id _Nullable response);

@interface LandingPageTemplate : UIViewController <NtvLandingPageInterface>

@property (nonatomic) RCTRootView *rootView;
@property (nonatomic) UIView *rootWebView;
@property (nonatomic) WKWebView *webView;
@property (nonatomic, copy) NtvEventHandleBlock handleEvent;
@property (nonatomic) BOOL shouldScroll;

@end

NS_ASSUME_NONNULL_END
