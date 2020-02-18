//
//  MRDSegmentedControl.h
//  MeridianiOSControls
//
//  Created by Cody Garvin on 11/14/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 A replacement for a UISegmentedControl that has a different style. This includes
 an underline for determining which segment is currently selected.
 */
@interface MRDSegmentedControl : UIControl

/**
 A way to get the total number of segmented cells.
 Returns the number of segments in the control, starting with 1.
 */
@property(nonatomic,readonly) NSUInteger numberOfSegments;


/**
 The current selected segment on the control. Can set it, can retrieve the current
 selected index.
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;




/**
 Create an instance of segmented control with given strings. These will represent
 the titles of the segmented control.

 @param items An array of strings that represent the titles in the given order.
 @return An instance of MRDSegmentedControl.
 */
- (instancetype)initWithItems:(NSArray<NSString *> *)items;


/**
 Add a section to the segmented control with the given title.

 @param title The title of the cell that will appear.
 @param index The index of the segment, that starts with 0.
 @param animated Whether the segment should animate the cell in.
 */
- (void)insertSegmentWithTitle:(nonnull NSString *)title
                       atIndex:(NSUInteger)index
                      animated:(BOOL)animated;


/**
 Attempt to remove a segment from the control that matches the given index.

 @param index The position the cell should be removed from.
 @param animated Whether the segment should animate the cell in.
 */
- (void)removeSegmentAtIndex:(NSUInteger)index animated:(BOOL)animated;


/**
 Removes all of the segments and will present an empty control.
 */
- (void)removeAllSegments;

/**
 A way to get a title for a given index.

 @param index The index the name of the segmented is wanted at, starting at 0.
 @return The string of the title for the given index.
 */
- (nullable NSString *)titleForSegmentAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
