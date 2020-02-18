//
//  MRDTextField.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/28/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRDTextFieldDelegate;

@interface MRDTextField : UITextField
/// Delegate object to inform of text field updates
@property (nonatomic, nullable, weak) id<MRDTextFieldDelegate> updateDelegate;
@end

@protocol MRDTextFieldDelegate <NSObject>
/// Called when the text field's text has changed
/// @param textField MRDTextField that was changed
/// @param text      full `NSString` text that is within the textfield
- (void)textField:(nonnull MRDTextField *)textField didUpdateText:(nonnull NSString *)text;
@end
