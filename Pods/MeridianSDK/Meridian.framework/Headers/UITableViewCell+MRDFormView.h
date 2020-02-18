//
//  UITableViewCell+MRDFormView.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/28/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRDFormCellIdentifier <NSObject>
/// Autogenerate Cell Reuse Identifier
@property (class, nonatomic, readonly, nonnull, copy) NSString *identifier;
@end

@interface UITableView (MRDFormView)
/// Register a class for a cell that conforms to our MRDFormCellIdentifier protocol
- (void)mrd_registerCellClass:(nonnull Class<MRDFormCellIdentifier>)cellClass;
@end

