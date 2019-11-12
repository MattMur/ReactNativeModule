//
//  LandingPageTemplate.h
//  react-native-nativo-ads
//
//  Created by Matthew Murray on 11/12/19.
//

#import <React/RCTRootView.h>
#import <NativoSDK/NativoSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface LandingPageTemplate : UIViewController <NtvLandingPageInterface>

@property (nonatomic) RCTRootView *rootView;
@property (nonatomic, readonly) WKWebView *contentWKWebView;
@property (nonatomic, readonly) UIImageView *authorImageView;
@property (nonatomic, readonly) UIImageView *previewImageView;
- (void)handleExternalLink:(nonnull NSURL *)link;

@end

NS_ASSUME_NONNULL_END
