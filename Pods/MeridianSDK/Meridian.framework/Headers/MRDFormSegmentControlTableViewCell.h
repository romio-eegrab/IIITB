//
//  MRDFormSegmentControlTableViewCell.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 10/1/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import "MRDFormViewTableViewCell.h"

@class MRDFormSegmentRow;
@protocol MRDFormSegmentControlTableViewCellDelegate;

@interface MRDFormSegmentControlTableViewCell : MRDFormViewTableViewCell
/// Delegate to inform of selection changes to our segment control
@property (nonatomic, nullable, weak) id<MRDFormSegmentControlTableViewCellDelegate> delegate;
@end

@protocol MRDFormSegmentControlTableViewCellDelegate <NSObject>
/// Notifies our delegate of a selected segment index change
/// @param cell SegmentControlCell that generated the message
/// @param selectedIndex Newly selected segment control index
- (void)segmentCell:(nonnull MRDFormSegmentControlTableViewCell *)cell selectedIndex:(NSUInteger)selectedIndex;
@end
