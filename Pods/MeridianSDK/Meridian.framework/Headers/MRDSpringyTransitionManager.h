//
//  MRDSpringyTransitionManager.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 7/21/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRDSpringyTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>
/// Whether or not we're presenting (YES) or dismissing (NO). Default is @c YES
@property (nonatomic, assign) BOOL presenting;

/// Whether or not to present with an overlay behind the modal. Default is @c YES
@property (nonatomic, assign) BOOL presentWithOverlay;

/// Spring dampening. Default value is @c 0.8
@property (nonatomic, assign) CGFloat dampening;
/// Spring Velocity. Default value is @c 1.0
@property (nonatomic, assign) CGFloat velocity;

/// Horizontal inset value as a percentage (`0.0` - `1.0`) to use when calculating our `-insetRectForSize:`
/// Default value is `0.1`
@property (nonatomic, assign) CGFloat horizontalInset;

/// Vertical inset value as a percent (0.0-1.0) to use when calculating `-insetRectForSize:`
/// when the `size.width` is greater than our `size.height`
/// Default value is 0.1
@property (nonatomic, assign) CGFloat verticalInsetPortrait;

/// Vertical inset value as a percent (0.0-1.0) to use when calculating `-insetRectForSize:`
/// when the `size.height` is greater than our `size.width`
/// Default value is 0.2
@property (nonatomic, assign) CGFloat verticalInsetLandscape;

/// Preferred corner radius to use. Default value is 4.0
@property (nonatomic, assign) CGFloat viewCornerRadius;

/// @brief Calculate necessary inset rectangle for a given view size
///
/// When we present on iPad we want our modal to look proportional.
/// Since we always take ~80% of the width, if we're taller than we are wide
/// we want to also take ~80% of the height. If we're in landscape we want 90%.
/// There isn't really anything special about these values they just looked
/// pretty close and proportional. It feels nice so we use 'em.
///
/// @param size CGSize of the view we want to be inset from
/// @return CGRect inset for the given view size
- (CGRect)insetRectForSize:(CGSize)size;

@end
