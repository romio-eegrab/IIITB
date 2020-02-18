//
//  MRDNoResultsView.h
//  MeridianiOSControls
//
//  Created by Alex Belliotti on 3/19/19.
//  Copyright © 2019 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Displays a static message in the format "No results for 'foo'", where foo == the query text
/// intended to be used as a UITableView's backgroundView
@interface MRDNoResultsView : UIView

/// use this to configure the message label after init
@property (nonatomic, copy) NSString *queryText;

- (instancetype)initWithQueryText:(NSString *)queryText;

@end

NS_ASSUME_NONNULL_END
