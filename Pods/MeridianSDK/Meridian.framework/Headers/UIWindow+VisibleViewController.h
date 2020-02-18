//
//  UIWindow+VisibleViewController.h
//  MeridianiOSControls
//
//  Created by Stephen Kelly on 8/28/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (MRDVisibleViewController)
/// returns the currently visible viewcontroller
- (UIViewController *) mrd_visibleViewController;
@end
