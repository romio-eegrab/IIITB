//
//  MRDFormTextViewRow.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRDFormViewProtocols.h"

@interface MRDFormTextViewRow : NSObject <MRDFormRowProtocol>

/// Textview row with a placeholder value and a given text value
/// @param title       Title of the row
/// @param placeholder placeholder text for the text field
/// @param text        text value to start off with
+ (nonnull instancetype)textViewRowWithTitle:(nonnull NSString *)title placeholder:(nullable NSString *)placeholder text:(nullable NSString *)text;

/// Textview row with a placeholder value and a given text value
/// @param title       Title of the row
/// @param attributedPlaceholder attributed Placeholder text for the text field
/// @param text                  text value to start off with
+ (nonnull instancetype)textViewRowWithTitle:(nonnull NSString *)title attributedPlaceholder:(nullable NSAttributedString *)attributedPlaceholder text:(nullable NSString *)text;

/// Textview row with a placeholder value and a given attributed text value
/// Will allow for editing text attributes
/// @param title          Title of the row
/// @param placeholder    placeholder text for the text field
/// @param attributedText attributed text value to start off with
+ (nonnull instancetype)textViewRowWithTitle:(nonnull NSString *)title placeholder:(nullable NSString *)placeholder attributedText:(nullable NSAttributedString *)attributedText;

/// Textview row with a placeholder value and a given text value
/// Will allow for editing text attributes
/// @param title       Title of the row
/// @param attributedPlaceholder attributed Placeholder text for the text field
/// @param attributedText        attributed text value to start off with
+ (nonnull instancetype)textViewRowWithTitle:(nonnull NSString *)title attributedPlaceholder:(nullable NSAttributedString *)attributedPlaceholder attributedText:(nullable NSAttributedString *)attributedText;

/// Get the height necessary to display the text view when constrained to a specific width
/// @param width width of the view it must be contained within
/// @return Height necessary to show the entire bit of text
- (CGFloat)heightOfRowConstrainedToWidth:(CGFloat)width;

@end
