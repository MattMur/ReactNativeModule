#import "NativoAds.h"
#import "NativoAdsUtils.h"
#import "NtvSharedSectionDelegate.h"
#import <React/UIView+React.h>
#import <React/RCTRootView.h>
#import <React/RCTRootViewDelegate.h>
#import <React/RCTDevLoadingView.h>

@interface NativoAdManager ()
@end

@implementation NativoAdManager

RCT_EXPORT_MODULE(NativoAd)
RCT_EXPORT_VIEW_PROPERTY(sectionUrl, NSString)
RCT_EXPORT_VIEW_PROPERTY(locationId, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(nativeAdTemplate, NSString)
RCT_EXPORT_VIEW_PROPERTY(videoAdTemplate, NSString)
RCT_EXPORT_VIEW_PROPERTY(onNativeAdClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDisplayAdClick, RCTBubblingEventBlock)

- (UIView *)view
{
    NativoAd *nativoAd = [[NativoAd alloc] init];
    nativoAd.bridge = self.bridge;
    return nativoAd;
}

- (void)setBridge:(RCTBridge *)bridge {
#if RCT_DEV
    [bridge moduleForClass:[RCTDevLoadingView class]];
#endif
    super.bridge = bridge;
}

@end


# pragma mark - Nativo Ad

@interface NativoAd () <RCTRootViewDelegate>
@property (nonatomic) NtvAdData *adData;
@property (nonatomic) NSString *sectionUrl;
@property (nonatomic) NSNumber *locationId;
@property (nonatomic) NSString *nativeAdTemplate;
@property (nonatomic) NSString *videoAdTemplate;
@end

@implementation NativoAd

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)setLocationId:(NSNumber *)locationId {
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
    self.adData = adData;
    
    // Get main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *appProperties = @{ @"adTitle" : adData.title,
                                         @"adDescription" : adData.previewText,
                                         @"adAuthorName" : adData.authorName,
                                         @"adDate" : adData.date };
        
        BOOL isNativeTemplate = adData.adType == Native || adData.adType == Display;
        BOOL isVideoTemplate = adData.adType == ScrollToPlayVideo || adData.adType == ClickToPlayVideo;
        RCTRootView *templateView;
        if (isNativeTemplate && self.nativeAdTemplate) {
            templateView = [[NativeAdTemplate alloc] initWithBridge:self.bridge
                                                         moduleName:self.nativeAdTemplate
                                                  initialProperties:appProperties];
        } else if (isVideoTemplate && self.videoAdTemplate) {
            templateView = [[VideoAdTemplate alloc] initWithBridge:self.bridge
                                                         moduleName:self.videoAdTemplate
                                                  initialProperties:appProperties];
        } else {
            return;
        }
        
        // Inject template
        templateView.delegate = self;
        templateView.frame = self.bounds;
        [self addSubview:templateView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIScrollView *container = [NativoAdsUtils getParentScrollViewForView:self];
            if (container && templateView) {
                // Place ad in view
                [NativoSDK placeAdInView:templateView atLocationIdentifier:self.locationId inContainer:container forSection:self.sectionUrl options:nil];
                
                // Add click handler
                UITapGestureRecognizer *clickEvent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickAdUnit:)];
                [self addGestureRecognizer:clickEvent];
            }
        });
    });
}

- (void)didClickAdUnit:(id)sel {
    
    NtvAdData *adData = self.adData;
    switch (adData.adType) {
        case Native:
            if (!self.onNativeAdClick) {
                return;
            }
            self.onNativeAdClick(@{ @"title" : adData.title,
                                    @"description" : adData.previewText,
                                    @"authorName" : adData.authorName,
                                    @"authorUrl" : adData.authorURL,
                                    @"date" : adData.date,
                                    @"locationId" : adData.locationIdentifier,
                                    @"sectionUrl" : self.sectionUrl
            });
            break;
            
        case Display:
            if (!self.onDisplayAdClick) {
                return;
            }
            self.onDisplayAdClick(@{ @"url" : adData.sponsoredArticleURL.absoluteString });
            break;
            
        default:
            break;
    }
}

#pragma mark - RCTRootViewDelegate

- (void)rootViewDidChangeIntrinsicSize:(RCTRootView *)rootView {
    
}

@end
