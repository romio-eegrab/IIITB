//
//  MRDBottomSheetProtocols.h
//  MeridianiOSControls
//
//  Created by Cody Garvin on 9/1/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#ifndef MRDBottomSheetProtocols_h
#define MRDBottomSheetProtocols_h

@class MRPlacemark, MRDBottomSheetSnapPoints, MRDBottomSheetViewController, MRDBottomSheetAbstractController;

typedef NS_ENUM(NSInteger, MRBottomSheetAllowance) {
    MRBottomSheetAllowanceThreeState,
    MRBottomSheetAllowanceTwoState,
    MRBottomSheetAllowanceNone,
};

/**
 Delegation to the parent view controller of the sheet or the child view
 controllers that are placed inside the sheet. This allows them to react to
 certain adjustments and actions that can come from users.
 */
@protocol MRDBottomSheetDelegate <NSObject>

@optional

/// Lets the delegate know the sheet has changed height and if scrolling is
/// suggested to be used within. This allows the delegate to know when they
/// should be locked to avoid interfering with dragging gestures.
- (void)scrollStateDidChangeToEnabled:(BOOL)scrollEnabled;

/// Alerts the delegate that the sheet will become hidden.
- (void)sheetWillDismiss;

/// Alerts the delegate that the sheet has become hidden.
- (void)sheetDidDismiss;

/// Alerts the delegate that the bottom sheet close button has been clicked.  The delegate should respond with YES
/// if the bottom sheet should be dismissed.
- (BOOL)bottomSheet:(nonnull MRDBottomSheetViewController *)sheetViewController
     willRemoveChild:(nullable MRDBottomSheetAbstractController *)childViewController;

/// The sheet and its child were actually removed from the view hierarchy
- (void)bottomSheet:(nonnull MRDBottomSheetViewController *)sheetViewController
     didRemoveChild:(nullable MRDBottomSheetAbstractController *)childViewController;

/// Alerts the delegate that the height changed to the given height.
- (void)sheetHeightDidChangeToCompletion:(CGFloat)competion;

/// Gives the delegate a hook to compute its own snap points, otherwise MRDBottomSheetViewController will make a best
/// effort to determine them.
- (nullable MRDBottomSheetSnapPoints *)snapPointsForContainerBounds:(CGRect)bounds;

/// MRDBottomSheetViewController makes a best effort to position its own view in a way that will not obstruct the
/// keyboard.  Position your content within MRDBottomSheetViewController's view frame.

/// Lets the delegate know that the keyboard will show and passes the
/// notification along to grab keyboard metrics to know if it will interfere or
/// not.  Use this versus receiving the notification directly to coordinate with MRDBottomSheetViewController.
/// This method is no longer used and will be removed in a future release.
- (void)keyboardWillShowWithNotification:(nonnull NSNotification *)notification __attribute__((deprecated("since version 5.3.0", "")));

/// Lets the delegate know that the keyboard did show and passes the
/// notification along to grab keyboard metrics to know if it will interfere or
/// not.  Use this versus receiving the notification directly to coordinate with MRDBottomSheetViewController.
/// This method is no longer used and will be removed in a future release.
- (void)keyboardDidShowWithNotification:(nonnull NSNotification *)notification __attribute__((deprecated("since version 5.3.0", "")));

/// Lets the delegate know that the keyboard will hide and passes the
/// notification along to grab keyboard metrics to know if it will interfere or
/// not.  Use this versus receiving the notification directly to coordinate with MRDBottomSheetViewController.
/// This method is no longer used and will be removed in a future release.
- (void)keyboardWillHideWithNotification:(nonnull NSNotification *)notification __attribute__((deprecated("since version 5.3.0", "")));

/// Lets the delegate know that the keyboard did hide and passes the
/// notification along to grab keyboard metrics to know if it will interfere or
/// not.  Use this versus receiving the notification directly to coordinate with MRDBottomSheetViewController.
/// This method is no longer used and will be removed in a future release.
- (void)keyboardDidHideWithNotification:(nonnull NSNotification *)notification __attribute__((deprecated("since version 5.3.0", "")));

@end

/**
 This acts as a mediator design pattern to execute all parties that may be
 interested in any methods from MRDBottomSheetDelegate. These methods relate to
 the actions of MRBottomSheetViewController. It is recommended the
 implementation holds weak references as they drop out. Simply add and remove
 the instance that adheres to MRDBottomSheetDelegate and they will get their
 mediated response.
 */
@protocol MRDBottomSheetMediator <NSObject, MRDBottomSheetDelegate>

/// Adds the delegate to the mediator to call when a MRBottomSheetDelegate
/// method is executed on the MRBottomSheetViewController.
- (void)addBottomSheetDelegate:(nonnull id<MRDBottomSheetDelegate>)delegate;

/// Removes the delegate from the mediator to cease receiving execution.
- (void)removeBottomSheetDelegate:(nonnull id<MRDBottomSheetDelegate>)delegate;

@optional
/// A convenient way to execute a selector on all mediator peers.
- (void)executeSelector:(nonnull SEL)selector;

@end

/**
 Utilize these methods for MRDBottomSheetAbstractViewController children to 
 talk back to their container. Useful for loading data and changing states of
 the sheet container itself.
 */
@protocol MRDBottomSheetAbstractDelegate <NSObject>

/**
 Called when a child view controller may have a radical state change because of 
 data changes.

 @param viewController The view controller child that had a change associate 
 with it.
 @param data The data that was loaded or not, can be any form of data. Check type
 before utilizing.
 @param error Whether an error was returned when loading data.
 */
- (void)viewController:(nonnull UIViewController *)viewController
           didLoadData:(id _Nullable)data
             withError:(NSError * _Nullable)error;

/**
 *
 *   Lets the bottom sheet parent know that the parent will be adjusting to a new height. This is handy for animating
 *   the keyboard in/out.
 *   @param viewController The view controller child that will be changing height.
 *   @param newHeight The view controller will be changed to this new height.
 *   @return void block When called, will execute the bottom sheet's height change. This is intended to be called as part of an animation block.
 *   @warning This method is no longer used and will be removed in a future release.
*/
- (void (^__nonnull)(void))viewController:(nonnull UIViewController *)viewController
    willChangeHeightTo:(CGFloat)newHeight __attribute__((deprecated("since version 5.3.0", "")));

@end

/**
 An interface that provides an ability to be notified when data fails or
 successfully loads.
 */
@protocol MRDPlacemarkSheetDataSourceDelegate <NSObject>

/**
 Executed when a response comes back for loading data in the placemark sheet.
 
 @param data The data that is associated with the placemark that can be used to 
 create cells.
 @param error If an error happens during load, it is passed along to handle 
 appropriately.
 */
- (void)data:(MRPlacemark * _Nullable)data loadedWithError:(NSError * _Nullable)error;

@optional

/**
 Executed when a url is executed, most likely by tapping a link with the url
 associated with it.

 @param url The address that should be loaded.
 */
- (void)requestedLoadOfURL:(NSURL * _Nonnull)url;

@end

/**
 Provides an interface for a UITableViewDataSource to manage cell display in 
 placemark details sheets. Includes an ability to be notified when data is ready.
 */
@protocol MRDAnnotationTableDataSource <UITableViewDataSource>

/// Ability to be notified when data has successfully loaded.
@property (nonatomic, nullable, weak) id<MRDPlacemarkSheetDataSourceDelegate> callbackDelegate;
@property (nonatomic, nullable, strong) UIImage *heroImage;
@property (nonatomic) UIViewContentMode heroImageContentMode;
@optional

/**
 Allows the datasource to have an opportunity to execute actions that may be
 associated with data.

 @param indexPath The index of the data that may have an action that needs to
 be executed.
 @param viewController The viewcontroller that actions should be performed on.
 */
- (void)executeActionForIndexPath:(nonnull NSIndexPath *)indexPath
               withViewController:(nullable UIViewController *)viewController;
@end

#endif /* MRDBottomSheetProtocols_h */
