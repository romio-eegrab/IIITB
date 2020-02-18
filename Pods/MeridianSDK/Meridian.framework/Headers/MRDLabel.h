//
//  MRDLabel.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 10/2/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRDLabel : UILabel
/// Get a title label
+ (nonnull instancetype)titleLabel;

/// Get the height necessary for this label to display all its content constrained to a width
/// @param width @c CGFloat width to constaint to
/// @return @c CGFloat height needed to show all the content
- (CGFloat)heightOfLabelConstrainedToWidth:(CGFloat)width;

@end
