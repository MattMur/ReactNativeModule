#import "NativoAds.h"
#import "NativoAdsUtils.h"
#import "NtvSharedSectionDelegate.h"
#import <React/UIView+React.h>
#import <React/RCTRootView.h>
#import <React/RCTRootViewDelegate.h>

@interface NativoAdManager ()
@end

@implementation NativoAdManager

RCT_EXPORT_MODULE(NativoAd)
RCT_EXPORT_VIEW_PROPERTY(sectionUrl, NSString)
RCT_EXPORT_VIEW_PROPERTY(locationId, NSString)
RCT_EXPORT_VIEW_PROPERTY(nativeAdTemplate, NSString)
RCT_EXPORT_VIEW_PROPERTY(videoAdTemplate, NSString)

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
@property (nonatomic) NSString *nativeAdTemplate;
@property (nonatomic) NSString *videoAdTemplate;
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
    if (self.sectionUrl && self.locationId) {
        // Set ad view with shared section delegate
        [NtvSharedSectionDelegate setAdView:self forSectionUrl:self.sectionUrl atLocationIdentifier:self.locationId];
        
        // If we have ad data, inject ad view, otherwise prefetch ad
        NtvAdData *adData = [NativoSDK getCachedAdAtLocationIdentifier:self.locationId forSection:self.sectionUrl];
        if (adData) {
            [self injectWithAdData:adData];
        } else {
            [NativoSDK prefetchAdForSection:self.sectionUrl atLocationIdentifier:self.locationId options:nil];
        }
    }
}

- (void)injectWithAdData:(NtvAdData *)adData {
    // Get main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *appProperties = @{ @"adTitle" : adData.title,
                                         @"adDescription" : adData.previewText,
                                         @"adAuthorName" : adData.authorName,
                                         @"adDate" : adData.date };
        
        BOOL isNativeTemplate = adData.adType == Native || adData.adType == Display;
        BOOL isVideoTemplate = adData.adType == ScrollToPlayVideo || adData.adType == ClickToPlayVideo;
        RCTRootView *templateView;
        if (isNativeTemplate) {
            templateView = [[NativeAdTemplate alloc] initWithBridge:self.bridge
                                                         moduleName:self.nativeAdTemplate
                                                  initialProperties:appProperties];
        } else if (isVideoTemplate) {
            templateView = [[VideoAdTemplate alloc] initWithBridge:self.bridge
                                                         moduleName:self.videoAdTemplate
                                                  initialProperties:appProperties];
        }
        
        // Inject template
        templateView.delegate = self;
        templateView.frame = self.bounds;
        [self addSubview:templateView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIScrollView *container = [NativoAdsUtils getParentScrollViewForView:self];
            if (container && templateView) {
                [NativoSDK placeAdInView:templateView atLocationIdentifier:self.locationId inContainer:container forSection:self.sectionUrl options:nil];
            }
        });
    });
}

#pragma mark - RCTRootViewDelegate

- (void)rootViewDidChangeIntrinsicSize:(RCTRootView *)rootView {
    
}

@end
