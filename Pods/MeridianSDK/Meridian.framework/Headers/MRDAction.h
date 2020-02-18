//
//  MRDAction.h
//  Meridian
//
//  Created by Cody Garvin on 9/21/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#ifndef MRDAction_h
#define MRDAction_h


/**
 MRDAction allows the ability to create actions that can be executed on various 
 types such as when table cells are tapped. Just implement the performWithViewController: 
 method and you are compliant.
 */
@protocol MRDAction <NSObject>


/**
 Executed when this action is executed. A view controller is supplied for 
 potential presentations or navigation stack manipulation.

 @param viewController The view controller that can potentially be manipulated
 or acted on.
 */
- (void)performWithViewController:(nonnull UIViewController *)viewController;

@optional
/**
 Executed when this action is executed. A view controller is supplied for
 potential presentations or navigation stack manipulation.

 @param viewController The view controller that can potentially be manipulated
 or acted on.
 @param userInfo optional User info dictionary to pass along
 */
- (void)performWithViewController:(nullable UIViewController *)viewController userInfo:(nullable NSDictionary *)userInfo;
@end

#endif /* MRDAction_h */
