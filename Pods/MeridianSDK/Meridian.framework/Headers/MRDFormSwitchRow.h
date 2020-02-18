//
//  MRDFormSwitchRow.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRDFormViewProtocols.h"

@interface MRDFormSwitchRow : NSObject <MRDFormRowProtocol>
/// Switch row with a given title and on state
/// @param title Title to give the row
/// @param on    BOOL if the switch should be on or not
+ (nonnull instancetype)switchRowWithTitle:(nonnull NSString *)title on:(BOOL)on;
@end
