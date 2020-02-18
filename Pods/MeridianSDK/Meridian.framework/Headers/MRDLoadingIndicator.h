//
//  MRDLoadingIndicator.h
//  MeridianiOSControls
//
//  Created by Christen Hubbard on 3/14/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRDLoadingIndicatorSize) {
    MRDLoadingIndicatorSmall,
    MRDLoadingIndicatorLarge,
};

NS_ASSUME_NONNULL_BEGIN

@interface MRDLoadingIndicator : UIView
- (instancetype)initWithSize:(MRDLoadingIndicatorSize)size color:(UIColor *)color;
- (void)startAnimating;
- (void)stopAnimating;
// setting these properties will override the current settings
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL applyGradations;
@end

NS_ASSUME_NONNULL_END
