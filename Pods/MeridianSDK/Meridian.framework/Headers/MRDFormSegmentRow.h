//
//  MRDFormSegmentRow.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRDFormViewProtocols.h"

@interface MRDFormSegmentRow : NSObject <MRDFormRowProtocol>

/// Array of Segment titles to use in the segment control
@property (nonatomic, readonly, nonnull, copy) NSArray <NSString *> *segmentTitles;

/// Currently selected Segment index
@property (nonatomic, readonly, assign) NSUInteger selectedSegmentIndex;

/// Create a segmented row with a given title, segment titles,
/// and selected segment index
/// @param title                Title for the row
/// @param segmentTitles        Segment control titles
/// @param selectedSegmentIndex Default selected segment index
+ (nonnull instancetype)segmentRowWithTitle:(nonnull NSString *)title segmentTitles:(nonnull NSArray <NSString *> *)segmentTitles selectedSegmentIndex:(NSUInteger)selectedSegmentIndex;
@end
