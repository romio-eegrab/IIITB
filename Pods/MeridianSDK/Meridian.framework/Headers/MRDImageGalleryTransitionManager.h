//
//  MRDImageGalleryTransitionManager.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 10/16/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRDImageGalleryTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>

/// Whether or not we're presenting (YES) or dismissing (NO). Default is @c YES
@property (nonatomic, assign) BOOL presenting;

/// Final frame to animate to
@property (nonatomic, assign) CGRect finalFrame;
/// Initial frame to animate from
@property (nonatomic, assign) CGRect initialFrame;

/// Default final frame that will be used if 
/// `finalFrame` if equal to `CGRectZero`
@property (nonatomic, readonly) CGRect defaultFinalFrame;

/// `YES` if we should fade the 'toViewController' in
/// Default value is `NO`
@property (nonatomic, assign) BOOL fadeToViewControllerIn;

/// Placeholder image to use when animating in/out
@property (nonatomic, copy, nullable) UIImage *image;
@end
