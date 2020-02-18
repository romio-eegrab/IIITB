//
//  MRDFormTextViewTableViewCell.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/29/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRDFormViewTableViewCell.h"

@protocol MRDFormTextViewTableViewCellDelegate;

@class MRDFormTextViewRow;

@interface MRDFormTextViewTableViewCell : UITableViewCell <MRDFormCellIdentifier>
/// Delegate to inform of content changes/other necessary events
@property (nonatomic, nullable, weak) id<MRDFormTextViewTableViewCellDelegate> delegate;
/// Configure our row with a given `MRDFormTextViewRow`
- (void)configure:(nonnull MRDFormTextViewRow *)row;
@end

@protocol MRDFormTextViewTableViewCellDelegate <NSObject>
/// Called when our text has been changed/updated
/// @param cell Cell that generated the message/notification
/// @param text full/updated text contained in the text view
- (void)textViewCell:(nonnull MRDFormTextViewTableViewCell *)cell updatedText:(nonnull NSString *)text;

/// Called when our attributed text has been changed/updated
/// @param cell           Cell that generated the message/notification
/// @param attributedText full/updated text contained in the text view
- (void)textViewCell:(nonnull MRDFormTextViewTableViewCell *)cell updatedAttributedText:(nonnull NSAttributedString *)attributedText;

/// Notify our delegate that we finished editing
- (void)textViewCellDidEndEditing:(nonnull MRDFormTextViewTableViewCell *)cell;
@end
