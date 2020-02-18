//
//  MRDFormSwitchTableViewCell.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 10/1/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRDFormViewTableViewCell.h"

@protocol MRDFormSwitchTableViewCellDelegate;

@class MRDFormSwitchRow;

@interface MRDFormSwitchTableViewCell : MRDFormViewTableViewCell
/// Delegate to notify of events releated to our switch
@property (nonatomic, nullable, weak) id<MRDFormSwitchTableViewCellDelegate> delegate;
@end

@protocol MRDFormSwitchTableViewCellDelegate <NSObject>
/// Notify of the current switch state
/// @param cell SwitchTableViewCell that generated the message
/// @param on   `YES` if the switch is 'on'. `NO` if it is not
- (void)switchRowCell:(nonnull MRDFormSwitchTableViewCell *)cell on:(BOOL)on;
@end
