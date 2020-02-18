//
//  MRDVerticalSegmentedControl.h
//  MRDBottomSheet
//
//  Created by Cody Garvin on 7/7/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Action block signature that is executed with segments that may have
/// actions associated with them.
typedef void(^MRDVerticalSegmentedAction)(void);


/**
 A vertical segmented control that can be created automatically by supplying 
 images or strings to display. This control will lay them out in the order they 
 are received top to bottom. It has the appearance of drop shadow plus blur as 
 well as adding dividers in between. In addition a theme color can be provided
 which will color the normal images or strings with this color.
 
 There are two ways to register for this control. One way is to use 
 addTarget:action:forControlEvents: on UIControlEventValueChanged. Then check 
 the selectedSegmentIndex property for the selected segment. The second way is 
 to supply an array of dictionaries containing two keys: `image` and `action`. 
 `image` will contain the name of the image to display, and `action` will be of 
 type MRDVerticalSegmentedAction. When the segment is tapped, it will execute the 
 action. It is important to note that with addTarget:action:forControlEvents:, 
 it will not execute twice in a row if a segment is tapped twice in a row. It 
 will only execute once because the value only changed once. Though using 
 actions it will execute no matter how many times in a row the same segment is 
 tapped.
 */
@interface MRDVerticalSegmentedControl : UIControl


/**
 Supply segments with either an array of image names, strings or dictionaries containing `image` and
 `action` of type MRDVerticalSegmentedAction. Optionally, `accessibilityLabel`
 can be supplied to add an accessibility label to the button.

 @param segments NSArray of images, strings or dictionaries.
 @return MRDVerticalSegmentedControl instance if successful.
 */
- (nullable instancetype)initWithSegments:(nonnull NSArray *)segments;

/// The total number of segments in the control.
@property (nonatomic, readonly) NSInteger numberOfSegments;

/// The segment last touched.
@property (nonatomic, readonly) NSInteger selectedSegmentIndex;

/// Enables or disables the blurred background. If disabled, a nearly opaque
/// white takes it's place.
@property (nonatomic, assign, getter=isBlurEnabled) BOOL blurEnabled;


/**
 If YES, sets the button at the specified index to show an activity indicating 
 spinner. This helps illustrate that a process is happening. Disable it by 
 passing NO for that same index.

 @param loading BOOL indicates if the loading spinner should be display and 
 spinning or not.
 @param index The index of the button to display or stop activity animation on.
 */
- (void)animateLoading:(BOOL)loading atIndex:(NSInteger)index;

/**
 Replace the segments in the control with a new set
 
 @param segments NSArray of images, strings or dictionaries.
 */
- (void)updateSegments:(nonnull NSArray *)segments;
@end
