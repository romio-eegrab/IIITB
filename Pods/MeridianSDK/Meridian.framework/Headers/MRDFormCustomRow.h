//
//  MRDFormCustomRow.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRDFormViewProtocols.h"

/// Selection Block, taking 2 arguments and returning nothing
/// @param view  View generated from the `viewBlock`. Can be `nil`
/// @param point Point in the view the selection happened
typedef void(^SelectionBlock)(UIView *_Nullable view, CGPoint point);

/// Data block, is passed the view in its current state and must return some object
/// @param view the View in this current state. Can be `nil` if `viewBlock` does not return a view
/// @return Should return `nil` if there are no changes, a value is there are changes
typedef id _Nullable(^DataBlock)(UIView *_Nullable view);

/// Block to call for retreiving the custom view.
typedef UIView *_Nonnull(^ViewBlock)(void);

/// Custom Row type
@interface MRDFormCustomRow : NSObject <MRDFormRowProtocol>

/// Block that is called to generate our view
/// This view *must* be laid out via AutoLayout and
/// *must* have constraints that would be compatible with an
/// automatic row height calculation of a `UITableView`.
/// An example of a sutable view would be a `UIView` filled by
/// a `UIStackView`. This will use automatic dimensions to determine height
/// which relies on AutoLayout calculations to fill the view. If you do not
/// use those you're going to have a bad time.
@property (nonatomic, readonly, nonnull, copy) ViewBlock viewBlock;

/// Action to call/perform when selected. `nil` to perform no action
@property (nonatomic, readonly, nullable, copy) SelectionBlock selectionAction;

/// Block to call to retrieve the data. `nil` If no data should be returned
@property (nonatomic, readonly, nullable, copy) DataBlock dataAction;


/// Create a custom row with a given title and various properties to delegate
/// action/selection/generation out to whomever wants to be responsible for it
/// @param title           Title for the row
/// @param viewBlock       Block to call to generate the view
/// @param selectionAction Action to call when the row is selected. If `nil` selection style will be none
/// @param dataAction      Block to call to get the current data value when the form is asked for its data. If `nil` this key/value pair will be ommited
+ (nonnull instancetype)customRowWithTitle:(nonnull NSString *)title view:(nonnull ViewBlock)viewBlock selectionAction:(nullable SelectionBlock)selectionAction dataAction:(nullable DataBlock)dataAction;

@end
