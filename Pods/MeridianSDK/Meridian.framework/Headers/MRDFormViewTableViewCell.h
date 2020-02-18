//
//  MRDFormViewTableViewCell.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/29/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+MRDFormView.h"
#import "MRDLabel.h"

@protocol MRDFormRowProtocol;

@interface MRDFormViewTableViewCell : UITableViewCell <MRDFormCellIdentifier>
/// Stackview holding our views
@property (nonatomic, nonnull, strong) UIStackView *stackView;
/// Title label
@property (nonatomic, nonnull, strong) MRDLabel *titleLabel;

/// Configure our cell with a given MRDFormRowProtocol
/// @param row the row to configure our cell with
- (void)configure:(nonnull NSObject<MRDFormRowProtocol> *)row;
@end
