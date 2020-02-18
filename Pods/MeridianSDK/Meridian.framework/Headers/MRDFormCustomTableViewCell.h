//
//  MRDFormCustomTableViewCell.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 10/1/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import "MRDFormViewTableViewCell.h"

@class MRDFormCustomRow;

@interface MRDFormCustomTableViewCell : MRDFormViewTableViewCell
/// Reference to our row, will not retain the row but it is necessary
/// to know who is it so we can call back to it for items like the view
/// that is should have
@property (nonatomic, nullable, weak) MRDFormCustomRow *row;
@end
