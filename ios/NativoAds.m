#import "NativoAds.h"
#import "NativoAdsUtils.h"
#import "RCTNtvSectionDelegate.h"

@interface NativoAdManager ()
@end

@implementation NativoAdManager

RCT_EXPORT_MODULE(NativoAd)
RCT_EXPORT_VIEW_PROPERTY(sectionUrl, NSString)
RCT_EXPORT_VIEW_PROPERTY(locationId, NSString)

- (UIView *)view
{
    NativoAd *nativoAd = [[NativoAd alloc] init];
    return nativoAd;
}

@end


# pragma mark - Nativo Ad

@interface NativoAd ()
@property (nonatomic) NSString *sectionUrl;
@property (nonatomic) NSString *locationId;
@property (nonatomic) NSDictionary *options;
@end

@implementation NativoAd

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)setSectionUrl:(NSString *)sectionUrl {
    NSLog(@"SectionUrl Set!!!");
    self.sectionUrlLabel.text = sectionUrl;
    [self.sectionUrlLabel sizeToFit];
    _sectionUrl = sectionUrl;
}

- (void)setLocationId:(NSString *)locationId {
    NSLog(@"LocationId Set!!!");
    self.locationIdLabel.text = locationId;
    [self.sectionUrlLabel sizeToFit];
    _locationId = locationId;
}

- (void)didMoveToSuperview {
    dispatch_async(dispatch_get_main_queue(), ^{
        [NativoSDK setSectionDelegate:[RCTNtvSectionDelegate sharedInstance] forSection:self.sectionUrl];
        UIScrollView *container = [NativoAdsUtils getParentScrollViewForView:self];
        if (container) {
            [NativoSDK placeAdInView:self atLocationIdentifier:self.locationId inContainer:container forSection:self.sectionUrl options:nil];
        }
    });
}

@end
