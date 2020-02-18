//
//  MRDFormSubtitleRow.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRDFormViewProtocols.h"

@interface MRDFormSubtitleRow : NSObject <MRDFormRowProtocol>
/// BOOL if we should use a monospaced font.
@property (nonatomic, readonly) BOOL monospaced;

/// Create a subtitle row with a given title and subtitle value
/// @param title    Title for the row
/// @param subtitle Subtitle value for the row
+ (nonnull instancetype)subtitleRowWithTitle:(nonnull NSString *)title subtitle:(nullable NSString *)subtitle;

/// Create a subtitle row with a given title and subtitle value.
/// Also set if the subtitle's font should be monospaced
/// @param title      Title for the row
/// @param subtitle   Subtitle value for the row
/// @param monospaced `YES` if the subtitle should use a monospaced font. `NO` otherwise.
+ (nonnull instancetype)subtitleRowWithTitle:(nonnull NSString *)title subtitle:(nullable NSString *)subtitle monoSpacedFont:(BOOL)monospaced;

@end
