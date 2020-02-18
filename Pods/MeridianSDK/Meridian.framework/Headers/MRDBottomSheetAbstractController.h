//
//  MRDBottomSheetAbstractController.h
//  MRDBottomSheet
//
//  Created by Cody Garvin on 6/12/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MRDBottomSheetViewController.h"
#import "MRDBottomSheetProtocols.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Used as an abstract class that automatically interfaces with MRDBottomSheetViewController
 as the parent controller for closing, scrolling and display. Inherit from this abstraction
 for a custom detailed view inside the MRDBottomSheetViewController.
 
 Note: This abstract class is autolayout enabled.
 
 Note: When migrating to Swift 3.2 / 4, it would be worth considering to remove 
 the abstract class and move to protocol extensions with default implementations.
 */
@interface MRDBottomSheetAbstractController : UIViewController <MRDBottomSheetDelegate>

/// Access to the close button to allow subclasses to manipulate positioning and
/// appearance.
@property (nonatomic, strong, readonly) UIButton *closeButton;

/// Top Content View to add subviews for top labels. Think of it as a header view.
/// Will take into account adjusting the content view top anchor point based on
/// if the topContentView is used or not. A topContentView will be enabled once
/// accessed via the property.
@property (nonatomic, nonnull, strong, readonly) UIView *topContentView;

/// Content View to add subviews
/// A lot like `UITableViewCell.contentView` this will be used to determine proper sizing
/// of the view. However since we are inherintely different (and more configurations
/// are possible such as adding a `UIScrollView` as a subview) there are some
/// notable differences.  If no minimumHeight is defined and we're not of a fixed size:
/// - The maximum amount we will show before `isExapandable` will be `YES`
///   is 1/3 of the total screen size. If subviews are added that will cause
///   our height to be beyond that **OR** if a `UIScrollView` (or subclass
///   such as `UITableView`/`UICollectionView`) is added as a subview
///   we will allow expanding to the maximum sheet size regardless of contents
/// - Minimum height will be automatically calulcated to fit the content
///   or 1/3 of the screen. Whichever is less (padding is automatically added)
/// - If one of the previous configurations causes us to automatically set
///   `isExapandable` to `YES`, toggling it to `NO` will have no effect.
/// To properly set a bottom constraint, set your external constraint priority to
/// UILayoutPriorityDefaultHigh, at least, to avoid conflicts with this class's internal
/// contentView bottom constraint.
@property (nonatomic, nonnull, strong, readonly) UIView *contentView;

/// When a bottom sheet is presented in the `MRMapViewController` by default
/// it will appear above the UITabBar (if one exists of course).
/// If this property is set to NO (and the UITabBarController it resides in
/// implements the MRDHidableTabBar protocol) the tabbar will be hidden
/// before the sheet is displayed.
@property (nonatomic, assign) BOOL shouldShowBehindTabBar;

/// Current sheet state. Useful for reacting to changes in our size on screen.
@property (nonatomic, readonly) MRDBottomSheetState currentState;

/// The lowest height that a sheet should appear.
@property (nonatomic, assign, readonly) CGFloat minimumHeight;

/// 
@property (nonatomic, assign, readonly) MRDBottomSheetHeightPercentage heightPercentage;

/// The fixed height the sheet will be presented at.
/// Only set/applicable if `- (instancetype)initWithCloseEnabled:(BOOL)closeEnabled fixedHeight:(CGFloat)fixedHeight`
/// was used for instaniation
@property (nonatomic, assign, readonly) CGFloat fixedHeight;

/// BOOL to check if we are a fixed size
@property (nonatomic, assign, readonly) BOOL isFixedSize;

/// Boolean to determine if we should be able to drag the the sheet up.
/// @note if we are a fixed size this will always return `NO`
@property (nonatomic, assign) BOOL isExpandable;

/// Whether the close button is enabled with this type of sheet.
@property (nonatomic, readonly) BOOL closeEnabled;

/// Boolean for if this sheet should not dismiss without either being
/// explicitly closed or forced to dismiss. Useful for things like direction
/// where we want the sheet to remain visible even if the user taps
/// on the map in arbitrary locations.
@property (nonatomic, assign) BOOL shouldBeSticky;

/// A mechanism to display when a sheet may be loading content or not. YES will
/// display a white translucent overlay with an activity indicator. NO will
/// remove the overlay and animating.
/// Changes to this property will trigger `-contentUpdated` to be called
@property (nonatomic, assign) BOOL isLoading;

/// Actions for when a sheet has internal actions and outsiders need to know
/// about them.
@property (nullable, nonatomic, weak) id<MRDBottomSheetAbstractDelegate> changeDelegate;

/// Determines the intial state of the bottom sheet as MRDBottomSheetStateHidden or MRDBottomSheetStateMinimum.
/// Defaults to YES.
@property (nonatomic, assign) BOOL startsHidden;

/// Determines the state of the bottom sheet immediately after it appears.  Defaults to MRDBottomSheetStateMaximum.
@property (nonatomic, assign) MRDBottomSheetState preferredStateAfterKeyboardAppears;

/// Determines the state of the bottom sheet after the keyboard disappears.  Defaults to MRDBottomSheetStateMinimum.
@property (nonatomic, assign) MRDBottomSheetState preferredStateAfterKeyboardDisappears;

/// Use this constant to tweak bottom padding after super sets it in contentUpdated.  Defaults to 46 points.
@property (nonatomic, assign) CGFloat contentViewBottomPadding;

/// Use this to determine the initial state of the BottomSheet containing the instance of this AbstractController
/// subclass when it first appears.
@property (nonatomic, assign) MRDBottomSheetState preferredInitialSelectionState;

/// This is added to the height calculated for MRDBottomSheetStateMinimum to determine the containing BottomSheet height
/// for MRDBottomSheetStatePeek.
@property (nonatomic, assign, readonly) CGFloat peekHeightOffset;

/// Our content has been updated so we should reflow our layout
/// to make sure everything appears as it should.
/// When `isLoading` is changed, this method is called
- (void)contentUpdated NS_REQUIRES_SUPER;

/**
 The best way to create a subclass sheet view controller. Make sure to override 
 this method if you would like to add default behavior such as minimum height 
 changes.

 @param closeEnabled Whether the close button should appear or not.
 @param minHeight The default height the sheet will appear at.
 @return The instance of the created view controller.
 */
- (instancetype)initWithCloseEnabled:(BOOL)closeEnabled
                       minimumHeight:(CGFloat)minHeight;

/**
 The best way to create a subclass sheet view controller. Make sure to override
 this method if you would like to add default behavior such as minimum height
 changes.
 
 @param closeEnabled Whether the close button should appear or not.
 @param minHeight The default height the sheet will appear at.
 @param heightPercentage The maximum percentage of screenheight the sheet should
 reach on all devices including tablets.
 @return The instance of the created view controller.
 */
- (instancetype)initWithCloseEnabled:(BOOL)closeEnabled
                       minimumHeight:(CGFloat)minHeight
                       maximumHeight:(MRDBottomSheetHeightPercentage)heightPercentage;
/**
 The best way to create a subclass sheet view controller if you want it to only
 ever appear at once size and not be expandable.

 @note If this is used, the sheet _can *not*_ be expanded. It will only ever appear
   at the given fixed size

 @param closeEnabled Whether the close button should appear or not.
 @param fixedHeight  Fixed height to appear at.
 @return The instance of the created view controller.
 */
- (instancetype)initWithCloseEnabled:(BOOL)closeEnabled
                         fixedHeight:(CGFloat)fixedHeight;
/**
 The best way to create a subclass sheet view controller. Make sure to override
 this method if you would like to add default behavior such as minimum height
 changes.

 @note Content _must_ be added to `contentView` when using this initializer

 @param closeEnabled Whether the close button should appear or not.
 @return The instance of the created view controller.
 */
+ (instancetype)bottomSheetWithCloseEnabled:(BOOL)closeEnabled;

/**
 The best way to create a subclass sheet view controller. Make sure to override
 this method if you would like to add default behavior such as minimum height
 changes.

 @note Content _must_ be added to `contentView` when using this initializer

 @param closeEnabled Whether the close button should appear or not.
 @return The instance of the created view controller.
 */
- (instancetype)initWithCloseEnabled:(BOOL)closeEnabled;

/// The best way to close and dismiss the sheet.
- (void)closeSheet;

/**
 Provides the ability to pass a drag / pan gesture to the parent 
 view controller to drag a sheet up and down. This can come into play 
 when there are other elements such as table views and scroll views 
 that may capture gesutre recognition but should cause the sheet to 
 move regardless.

 @param panGesture The gesture that is captured from a control that 
 needs to be passed along.
 */
- (void)forwardDragGesture:(UIPanGestureRecognizer *)panGesture;

@end

NS_ASSUME_NONNULL_END
