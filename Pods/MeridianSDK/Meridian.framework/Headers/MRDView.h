//
//  MRDView.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 2/8/18.
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRDBottomSheetAbstractController;

/// Custom UIView Subclass to be contained inside
/// an `MRDBottomSheetAbstractController`.
/// Exposes `subviews` as a KVO complient property
@interface MRDView : UIView
/// Value to override minimum height with.
/// Not used if less than 1;
@property (nonatomic, assign) CGFloat overrideMinimumHeight;

@property (nonatomic, nullable, readonly) MRDBottomSheetAbstractController *viewController;
@end
