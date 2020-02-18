//
//  MRDSlideTransitionManager.h
//  MRDSlideTransitionManager
//
//  Created by Stephen Kelly on 9/20/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRDSlideTransitionDirection) {
    MRDTransitionFromLeft,
    MRDTransitionFromRight
};

@interface MRDSlideTransitionManager : UIPercentDrivenInteractiveTransition <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

/// Direction the new controller transitions from (could be expanded to include top/bottom)
@property (nonatomic, assign) MRDSlideTransitionDirection transitionDirection;

/// Width of the new view being presented
@property (nonatomic, assign) CGFloat presentedViewWidth;

/// Length of the animation in seconds when presenting
@property (nonatomic, assign) CGFloat presentDuration;

/// Length of the animation in seconds when dismissing
@property (nonatomic, assign) CGFloat dismissDuration;

/// Alpha of old controller during new controller presentation (over a black background)
@property (nonatomic, assign) CGFloat fadeAlpha;

/// Disable the edge pan gesture. Default value is `NO`
@property (nonatomic, assign) BOOL disablePan;

/// String used as an accessibility label for the overlay view that is tapped to dismiss the presented controller
@property (nonatomic, nullable, assign) NSString *accessibilityLabelForClose;

/// Called to attach this transition manager to two previously initialized controllers
-(void)wireToControllers:(UIViewController *_Nonnull)toController fromController:(UIViewController *_Nonnull)fromController;
@end

