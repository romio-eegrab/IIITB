//
//  MRDBottomSheetViewController.h
//  MRDBottomSheet
//
//  Created by Cody Garvin on 6/7/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MRDBottomSheetProtocols.h"

extern CGFloat MRDBottomSheetCornerRadius;
extern CGFloat MRDBottomDropShadowThickness;
extern CGFloat MRDBottomStopHeightThreshold;
extern CGFloat MRDBottomFloatHandleHeight;

@class MRDBottomSheetAbstractController;

extern CGFloat MRDBottomSheetCornerRadius;

typedef NS_ENUM(NSInteger, MRDBottomSheetState) {
    MRDBottomSheetStateHidden,
    MRDBottomSheetStateMinimum,
    MRDBottomSheetStatePeek,
    MRDBottomSheetStateMiddle,
    MRDBottomSheetStateMaximum,
};

/**
 Used for specifying the maximum height percentage of the screen a floating sheet
 can become. This only applies to expandable floating sheets, normally found on
 normal width situations.

 - MRDBottomSheetHeightPercentageAuto: Default value for all sheets if not specified. Sized to 90% of the screen height.
 - MRDBottomSheetHeightPercentageLow: Sized to 30% of the screen height.
 - MRDBottomSheetHeightPercentageMid: Sized to 60% of the screen height.
 - MRDBottomSheetHeightPercentageTall: Sized to 90% of the screen height.
 */
typedef NS_ENUM(NSInteger, MRDBottomSheetHeightPercentage) {
    MRDBottomSheetHeightPercentageAuto  = 0,
    MRDBottomSheetHeightPercentageLow   = 30,
    MRDBottomSheetHeightPercentageMid   = 60,
    MRDBottomSheetHeightPercentageTall  = 90,
};

typedef NS_ENUM(NSInteger, MRDBottomSheetFloatLocation) {
    MRDBottomSheetFloatLocationUndefined = 0,
    MRDBottomSheetFloatLocationTopLeft,
    MRDBottomSheetFloatLocationTopRight,
};

extern CGFloat MRDBottomDropShadowThickness;
extern CGFloat MRDBottomSheetDefaultMaxHeightRatio;

@class MRDBottomSheetAbstractController;


/**
 A sheet that holds interactive content, usually in a table view. This has a 
 blurry / drop shadow view that is useful for on screen interaction at the same 
 time keeping the view it relates to in perspective.
 */
@interface MRDBottomSheetViewController : UIViewController

/// Delegate mediator allows anyone to register / unregister for delegation calls
/// as there may be more than one party that needs to know about events
@property (nonatomic, nullable, strong) id<MRDBottomSheetMediator> mediator;

/// Whether the child content controller should be able to scroll.
@property (nonatomic, readonly) BOOL scrollEnabled;


/// Whether the sheet view is able to be brought to a state beyond minimum.
/// eg: middle or maximum.
@property (nonatomic, assign) BOOL expandable;

/**
 Convenience method to add a bottom sheet with a detail view to a main view
 controller. Create the childSheetController that lives inside the sheet and pass
 along your main parent controller. This control takes the appearance of a sheet
 found in Apple Maps. This is usually the recommended path for most use cases.
 
 @param childSheetController An instance of MRDBottomSheetAbstractController that will
 contain the main functionality of the sheet inner views.
 @param parentHostController The main view controller that will host the sheet.
 @return An instance of the sheet that was added to the view controller passed.
 nil if one was not successfully created.
 */
+ (nullable MRDBottomSheetViewController *)addSheetController:(nonnull MRDBottomSheetAbstractController *)childSheetController
                                                 toController:(nonnull UIViewController *)parentHostController;


/**
 Convenience method to add a bottom sheet with a detail view to a main view 
 controller. Create the childSheetController that lives inside the sheet and pass
 along your main parent controller. This control takes the appearance of a sheet
 found in Apple Maps. This is usually the recommended path for most use cases. Note
 that it will auto determine whether to use a traditional sheet that takes the
 entire bottom of the device or a floating sheet based on the device type.
 Adds the option to explicitly control if the sheet is expandable.

 @param childSheetController An instance of MRDBottomSheetAbstractController that will
 contain the main functionality of the sheet inner views.
 @param parentHostController The main view controller that will host the sheet.
 @param expandable If NO, the default height is where it will always be. Still 
 determined by the child if it can be completely dismissed however.
 @return An instance of the sheet that was added to the view controller passed. 
 nil if one was not successfully created.
 */
+ (nullable MRDBottomSheetViewController *)addSheetController:(nonnull MRDBottomSheetAbstractController *)childSheetController
                                                 toController:(nonnull UIViewController *)parentHostController
                                                   expandable:(BOOL)expandable;

/**
 Convenience method to add a bottom sheet with a detail view to a main view
 controller. Create the childSheetController that lives inside the sheet and pass
 along your main parent controller. This control takes the appearance of a sheet
 found in Apple Maps. This is usually the recommended path for most use cases.
 Adds the option to explicitly decide if the sheet should float or not for
 tablets.
 
 @param childSheetController An instance of MRDBottomSheetAbstractController that will
 contain the main functionality of the sheet inner views.
 @param parentHostController The main view controller that will host the sheet.
 @param expandable If NO, the default height is where it will always be. Still
 determined by the child if it can be completely dismissed however.
 @return An instance of the sheet that was added to the view controller passed.
 nil if one was not successfully created.
 */
+ (nullable MRDBottomSheetViewController *)addSheetController:(nonnull MRDBottomSheetAbstractController *)childSheetController
                                                 toController:(nonnull UIViewController *)parentHostController
                                                   expandable:(BOOL)expandable
                                                floatOnTablet:(BOOL)floatOnTablet;


/**
 Convenience method to add a bottom sheet with a detail view to a main view
 controller. Create the childSheetController that lives inside the sheet and pass
 along your main parent controller. This control takes the appearance of a sheet
 found in Apple Maps. This is usually the recommended path for most use cases.
 Adds the option to specify a parentHostController subview to show the
 bottom sheet over (default is parentHostController.view)
 
 @param childSheetController An instance of MRDBottomSheetAbstractController that will
 contain the main functionality of the sheet inner views.
 @param parentHostController The main view controller that will host the sheet.
 @param parentView The subview within parentHostController to show the bottom sheet
 @param expandable If NO, the default height is where it will always be. Still
 determined by the child if it can be completely dismissed however.
 @return An instance of the sheet that was added to the view controller passed.
 nil if one was not successfully created.
 */
+ (nullable MRDBottomSheetViewController *)addSheetController:(nonnull MRDBottomSheetAbstractController *)childSheetController
                                                 toController:(nonnull UIViewController *)parentHostController
                                                 toView:(nonnull UIView *)parentView
                                                   expandable:(BOOL)expandable
                                                floatOnTablet:(BOOL)floatOnTablet;



/**
 Convenience method to add a floating sheet with a detail view to a main view
 controller that floats at a position given.
 
 @param childSheetController An instance of MRDBottomSheetAbstractController that will
 contain the main functionality of the sheet inner views.
 @param parentHostController The main view controller that will host the sheet.
 @param parentView The subview within parentHostController to show the bottom sheet
 @param expandable If NO, the default height is where it will always be. Still
 determined by the child if it can be completely dismissed however.
 @param location A position relative to the screen. In cases besides middle will
 add appropriate margins.
 @return An instance of the sheet that was added to the view controller passed.
 nil if one was not successfully created.
 */
+ (nullable MRDBottomSheetViewController *)addFloatingSheetController:(nonnull MRDBottomSheetAbstractController *)childSheetController
                                                         toController:(nonnull UIViewController *)parentHostController
                                                               toView:(nonnull UIView *)parentView
                                                           expandable:(BOOL)expandable
                                                             location:(MRDBottomSheetFloatLocation)location;
/**
 Convenience method to quickly remove a bottom sheet from a view controller.

 @param childSheetController An instance of MRDBottomSheetViewController that will be
 removed from your view controller.
 */
+ (void)removeSheetController:(nonnull MRDBottomSheetViewController *)childSheetController;

/**
 Creates an instance of MRDBottomSheetViewController with a view controller in 
 the content of such. The content controller should be of instance 
 MRDBottomSheetAbstractController.

 @param controller MRDBottomSheetAbstractController that tightly integrates with 
 MRDBottomSheetViewController via scrolling ability and dismissing. This is an 
 area that should be improved when migrated to Swift 3.2 / 4.0, protocol 
 extensions with default implementations instead of aggregation.
 @param minimumHeight The height the control should be from the bottom when 
 completely minimized.
 @return An instance of MRDBottomSheetViewController.
 */
- (nonnull instancetype)initWithViewController:(nonnull MRDBottomSheetAbstractController *)controller
                   withMinimumHeightFromBottom:(CGFloat)minimumHeight;

/**
 Creates an instance of MRDBottomSheetViewController with a view controller in 
 the content of such. The content controller should be of instance 
 MRDBottomSheetAbstractController.
 
 @param controller MRDBottomSheetAbstractController that tightly integrates with 
 MRDBottomSheetViewController via scrolling ability and dismissing. This is an 
 area that should be improved when migrated to Swift 3.2 / 4.0, protocol extensions 
 with default implementations instead of aggregation.
 @param minimumHeight The height the control should be from the bottom when 
 completely minimized.
 @param expandable If NO, the default height is where it will always be. Still 
 determined by the  child if it can be completely dismissed however.
 @return An instance of MRDBottomSheetViewController.
 */
- (nonnull instancetype)initWithViewController:(nonnull MRDBottomSheetAbstractController *)controller
                   withMinimumHeightFromBottom:(CGFloat)minimumHeight
                                    expandable:(BOOL)expandable;

/**
 Creates an instance of MRDBottomSheetViewController with a view controller in
 the content of such. The content controller should be of instance
 MRDBottomSheetAbstractController.
 Adds the option to specify a view within its parentViewController to display the sheet over
 
 @param controller MRDBottomSheetAbstractController that tightly integrates with
 MRDBottomSheetViewController via scrolling ability and dismissing. This is an
 area that should be improved when migrated to Swift 3.2 / 4.0, protocol extensions
 with default implementations instead of aggregation.
 @param minimumHeight The height the control should be from the bottom when
 completely minimized.
 @param expandable If NO, the default height is where it will always be. Still
 determined by the  child if it can be completely dismissed however.
 @param parentView  View that the bottom sheet controller will be displayed over.  If null parentViewController.view will be used.
 @return An instance of MRDBottomSheetViewController.
 */
- (nonnull instancetype)initWithViewController:(nonnull MRDBottomSheetAbstractController *)controller
                   withMinimumHeightFromBottom:(CGFloat)minimumHeight
                                    expandable:(BOOL)expandable
                                    parentView:(nullable UIView *)parentView;

/**
 If the sheet is hidden show and animate it to the minimum height specified. 
 If the sheet is already displayed, it will move to the default position 
 specified by minimumHeight. 
 @see initWithViewController:withMinimumHeightFromBottom:

 @param animated Whether the sheet will animate to that position or snap to it 
 instantly.
 @param completionHandler The block to be executed when animation completes, or
 if no animation is enabled executed immediately.
 @return the BottomSheetViewController's new view frame

 */
- (CGRect)showAtState:(MRDBottomSheetState)state
           animated:(BOOL)animated
         completion:(void(^_Nullable)(void))completionHandler;

/**
 Moves the sheet below the bottom of the screen and hides it. Animates to the 
 bottom if specified. Removes it from the parent controller after.
 
 @param animated Whether the sheet will animate to the bottom of the screen or 
 instantly disappear.
 */
- (void)closeAndRemove:(BOOL)animated;

/**
 Moves the sheet below the bottom of the screen and hides it. Animates to the
 bottom if specified. Removes it from the parent controller after.

 @param animated Whether the sheet will animate to the bottom of the screen or
 instantly disappear.
 @param forced YES if we should force removal even if the sheet is sticky. NO if not
 @param completion called on main after animation has completed and the sheet has been removed from the view hierarchy
 */
- (void)closeAndRemoveAnimated:(BOOL)animated forceRemoval:(BOOL)forced completion:(void (^__nullable)(void))completion;


/**
 Enable forwarding gestures by exposing the method that is used to move the 
 sheet up and down.

 @param recognizer UIPanGestureRecognizer that contains translation values.
 */
- (void)dragGesture:(nonnull UIPanGestureRecognizer *)recognizer;
@end
