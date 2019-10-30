//
//  ArticleNativeAdView.h
//  NativoInfiniteScrollSample
//
//  Copyright © 2019 Nativo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NativoSDK/NativoSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleNativeAdView : UIView <NtvAdInterface>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *previewTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIView *adChoicesIconView;

@end

NS_ASSUME_NONNULL_END
