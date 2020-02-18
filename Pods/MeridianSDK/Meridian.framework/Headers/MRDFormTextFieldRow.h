//
//  MRDFormTextFieldRow.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRDFormViewProtocols.h"

@interface MRDFormTextFieldRow : NSObject <MRDFormRowProtocol>

/// Textfield row with a placeholder value and a given text value
/// @param title       Title of the row
/// @param placeholder placeholder text for the text field
/// @param text        text value to start off with
+ (nonnull instancetype)textFieldRowWithTitle:(nonnull NSString *)title placeholder:(nullable NSString *)placeholder text:(nullable NSString *)text;

/// Textfield row with a placeholder value and a given text value
/// @param title       Title of the row
/// @param attributedPlaceholder attributed Placeholder text for the text field
/// @param text                  text value to start off with
+ (nonnull instancetype)textFieldRowWithTitle:(nonnull NSString *)title attributedPlaceholder:(nullable NSAttributedString *)attributedPlaceholder text:(nullable NSString *)text;

/// Textfield with secure input enabled with a given placeholder value
/// @param title       Title of the row
/// @param placeholder placeholder text for the text field
+ (nonnull instancetype)textFieldRowWithSecureInputTitle:(nonnull NSString *)title placeholder:(nullable NSString *)placeholder;

/// Textfield with secure input enabled with a given placeholder value
/// @param title       Title of the row
/// @param attributedPlaceholder attributed placeholder text for the text field
+ (nonnull instancetype)textFieldRowWithSecureInputTitle:(nonnull NSString *)title attributedPlaceholder:(nullable NSAttributedString *)attributedPlaceholder;
@end
