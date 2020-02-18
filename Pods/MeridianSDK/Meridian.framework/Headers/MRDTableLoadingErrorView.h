//
//  MRDTableLoadingErrorView.h
//  MeridianiOSControls
//
//  Created by Alex Belliotti on 2/11/19.
//  Copyright © 2019 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRDButton;

NS_ASSUME_NONNULL_BEGIN

@interface MRDTableLoadingErrorView : UIStackView

@property (nonatomic, weak, readonly) UILabel *messageLabel;
@property (nonatomic, weak, readonly) MRDButton *retryButton;

- (instancetype)initWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
