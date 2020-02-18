//
//  MRIntroPageView.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 7/20/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRDIntroPage;
@protocol MRDIntroPageViewDelegate;

/// The IntroPageView. Designed to be a view to display an `MRDIntroPage`
/// Must be laid out via autolayout
@interface MRDIntroPageView : UIView
/// `MRIntroPage` to show
@property (nonnull, nonatomic, copy) MRDIntroPage *introPage;
/// Delegate to inform of button presses if applicable
@property (nullable, nonatomic, weak) id<MRDIntroPageViewDelegate> delegate;

/// Create an `MRDIntroPageView` with a given `MRDIntroPage`
/// @param introPage `MRIntroPage` to show
+ (nonnull instancetype)introPageViewWithPage:(nonnull MRDIntroPage *)introPage;

/// Create an `MRDIntroPageView` with a given `MRDIntroPage`
/// @param introPage `MRDIntroPage` to show
/// @param delegate  Our delegate to inform of button presses
+ (nonnull instancetype)introPageViewWithPage:(nonnull MRDIntroPage *)introPage delegate:(nullable id<MRDIntroPageViewDelegate>)delegate;
@end

@protocol MRDIntroPageViewDelegate <NSObject>
/// Inform our delegate that our button was tapped
/// @param introPageView The `MRDIntroPageView` that had its button tapped
- (void)introPageViewDidTapButton:(nonnull MRDIntroPageView *)introPageView;
@end
