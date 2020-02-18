//
//  MRDTableView.h
//  MeridianiOSControls
//
//  Created by Alex Belliotti on 2/8/19.
//  Copyright © 2019 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSInteger kTableViewIndicatorTag;

NS_ASSUME_NONNULL_BEGIN

@interface MRDTableView : UITableView

@property (atomic, assign, readonly, getter=isLoading) BOOL loading;
@property (atomic, assign, readonly, getter=isError) BOOL error;

- (void)setLoading:(BOOL)loading animated:(BOOL)animated;
- (void)setLoadingError:(NSString *)message animated:(BOOL)animated;
- (void)clearLoadingError:(BOOL)animated completion:(void (^__nullable)(void))completion;

@end

@protocol MRDTableViewDelegate <UITableViewDelegate>

@optional
- (void)tableViewRetryButtonTapped:(UITableView *)tableView;
- (BOOL)tableViewIsEmpty:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
