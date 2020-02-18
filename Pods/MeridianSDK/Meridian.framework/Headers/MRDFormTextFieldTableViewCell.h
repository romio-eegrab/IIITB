//
//  MRDFormTextFieldTableViewCell.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/28/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRDFormViewTableViewCell.h"

@protocol MRDFormTextFieldTableViewCellDelegate;

@class MRDFormTextFieldRow;

@interface MRDFormTextFieldTableViewCell : MRDFormViewTableViewCell
/// Delegate to inform of cell textfield updates
@property (nonatomic, nullable, weak) id<MRDFormTextFieldTableViewCellDelegate> delegate;
@end

@protocol MRDFormTextFieldTableViewCellDelegate <NSObject>
/// Called to notify when the contents of the TextField within the cell have changed
/// @param cell MRDFormTextFieldTableViewCell generating the message
/// @param text Full/Updated text of the text field
- (void)textFieldCell:(nonnull MRDFormTextFieldTableViewCell *)cell updatedText:(nonnull NSString *)text;
@end
