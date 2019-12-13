#import <React/RCTViewManager.h>
#import <NativoSDK/NativoSDK.h>


@interface NativoAdManager : RCTViewManager
@end


@interface NativoAd: UIView

@property (nonatomic) RCTBridge *bridge;
@property (nonatomic) RCTBubblingEventBlock onDisplayAdClick;
@property (nonatomic) RCTBubblingEventBlock onNativeAdClick;
- (void)injectWithAdData:(NtvAdData *)adData;

@end
