//
//  MRDAttributedTableViewCell.h
//  Meridian
//
//  Created by Cody Garvin on 1/17/18.
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 Delegation for actions that could be associated with interaction with the
 attributed table view cell.
 */
@protocol MRDAttributedTableViewCellDelegate <NSObject>


/**
 If a link that contains a url address, it can be intercepted with this method.

 @param url The url address that has been requested.
 */
- (void)didTapAddressURL:(NSURL *)url;
@end


/**
 A tableview cell that can handle attributed text and converting html. In
 addition it can handle interaction.
 */
@interface MRDAttributedTableViewCell : UITableViewCell

/// The attributed string that should be displayed in the cell.
@property (nonatomic, copy) NSAttributedString *attributedText;

/// The delegate that will handle interaction methods.
@property (nonatomic, weak) id<MRDAttributedTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
