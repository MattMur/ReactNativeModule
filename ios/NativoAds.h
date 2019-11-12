#import <React/RCTViewManager.h>
#import <NativoSDK/NativoSDK.h>
#import "NativeAdTemplate.h"
#import "VideoAdTemplate.h"

@interface NativoAdManager : RCTViewManager
@end


@interface NativoAd: UIView

@property (nonatomic) RCTBridge *bridge;
- (void)injectWithAdData:(NtvAdData *)adData;

@end
