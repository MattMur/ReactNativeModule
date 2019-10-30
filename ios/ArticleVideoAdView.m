
#import "ArticleVideoAdView.h"
#import <AVFoundation/AVFoundation.h>

@implementation ArticleVideoAdView

- (NSString *)videoFillMode {
    return AVLayerVideoGravityResizeAspect;
}

@end
