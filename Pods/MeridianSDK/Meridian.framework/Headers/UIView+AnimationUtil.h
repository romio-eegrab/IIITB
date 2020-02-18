//
//  UIView+AnimationUtil.h
//  MeridianiOSControls
//
//  Created by Alex Belliotti on 3/7/19.
//  Copyright © 2019 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AnimationUtil)

+ (UIViewAnimationOptions)mrdAnimationOptionsForCurve:(UIViewAnimationCurve)curve;

@end

NS_ASSUME_NONNULL_END
