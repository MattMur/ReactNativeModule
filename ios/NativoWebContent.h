
#import <React/RCTViewManager.h>
#import <NativoSDK/NativoSDK.h>
#import "LandingPageTemplate.h"


@interface NativoWebContentManager : RCTViewManager
@end

@interface NativoWebContentView : UIView
@property (nonatomic) NtvContentWebView *nativoWebView;
@property (nonatomic) LandingPageTemplate *templateProxy;
@property (nonatomic) NSString *sectionUrl;
@property (nonatomic) NSNumber *locationId;
@property (nonatomic) BOOL *shouldScroll;
@property (nonatomic) RCTBubblingEventBlock onFinishLoading;
@property (nonatomic) RCTBubblingEventBlock onClickExternalLink;
@end
