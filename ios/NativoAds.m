#import "NativoAds.h"
#import "NativoAdsUtils.h"
#import "RCTNtvSectionDelegate.h"
#import <React/UIView+React.h>
#import <React/RCTRootView.h>
#import <React/RCTRootViewDelegate.h>

@interface NativoAdManager ()
@end

@implementation NativoAdManager

RCT_EXPORT_MODULE(NativoAd)
RCT_EXPORT_VIEW_PROPERTY(sectionUrl, NSString)
RCT_EXPORT_VIEW_PROPERTY(locationId, NSString)
RCT_EXPORT_VIEW_PROPERTY(nativeTemplate, NSString)
RCT_EXPORT_VIEW_PROPERTY(videoTemplate, NSString)

- (UIView *)view
{
    NativoAd *nativoAd = [[NativoAd alloc] init];
    nativoAd.bridge = self.bridge;
    return nativoAd;
}

@end


# pragma mark - Nativo Ad

@interface NativoAd () <RCTRootViewDelegate>
@property (nonatomic) NSString *sectionUrl;
@property (nonatomic) NSString *locationId;
@property (nonatomic) NSString *nativeTemplate;
@property (nonatomic) NSString *videoTemplate;
@end

@implementation NativoAd

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)setSectionUrl:(NSString *)sectionUrl {
    NSLog(@"SectionUrl Set!!!");
    _sectionUrl = sectionUrl;
}

- (void)setLocationId:(NSString *)locationId {
    NSLog(@"LocationId Set!!!");
    _locationId = locationId;
}

- (void)didMoveToSuperview {
    [NativoSDK setSectionDelegate:[RCTNtvSectionDelegate sharedInstance] forSection:self.sectionUrl];
    NtvAdData *adData = [NativoSDK getCachedAdAtLocationIdentifier:self.locationId forSection:self.sectionUrl];
    
    if (adData) {
        [self injectWithAdData:adData];
    } else {
        [NativoSDK prefetchAdForSection:self.sectionUrl atLocationIdentifier:self.locationId options:nil];
    }
}

- (void)injectWithAdData:(NtvAdData *)adData {
    // Get main thread
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSDictionary *appProperties = @{ @"adTitle" : adData.title,
                                         @"adDescription" : adData.previewText,
                                         @"adAuthorName" : adData.authorName,
                                         @"adDate" : adData.date };
        
        BOOL isNativeTemplate = adData.adType == Native || adData.adType == Display;
        BOOL isVideoTemplate = adData.adType == ScrollToPlayVideo || adData.adType == ClickToPlayVideo;
        RCTRootView *templateView;
        if (isNativeTemplate) {
            templateView = [[NativeAdTemplate alloc] initWithBridge:self.bridge
                                                         moduleName:self.nativeTemplate
                                                  initialProperties:appProperties];
        } else if (isVideoTemplate) {
            templateView = [[VideoAdTemplate alloc] initWithBridge:self.bridge
                                                         moduleName:self.videoTemplate
                                                  initialProperties:appProperties];
        }
        
        UIScrollView *container = [NativoAdsUtils getParentScrollViewForView:self];
        if (container && templateView) {
            [NativoSDK placeAdInView:templateView atLocationIdentifier:self.locationId inContainer:container forSection:self.sectionUrl options:nil];
                        
            // Add click event for landing page
            
            // Inject template
            templateView.delegate = self;
            templateView.frame = self.bounds;
            [self addSubview:templateView];
        }
    });
}

#pragma mark - RCTRootViewDelegate

- (void)rootViewDidChangeIntrinsicSize:(RCTRootView *)rootView {
    
}

@end
