//
//  MRDFormSection.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRDFormViewProtocols.h"

@interface MRDFormSection : NSObject <MRDFormSectionProtocol>
/// Create a MRDFormSection with a given title and array of rows
/// @param title Optional title to give the section
/// @param rows  Array of rows for the section to have
+ (nonnull instancetype)sectionWithTitle:(nullable NSString *)title rows:(nonnull NSArray <MRDFormRowProtocol> *)rows;

@end
