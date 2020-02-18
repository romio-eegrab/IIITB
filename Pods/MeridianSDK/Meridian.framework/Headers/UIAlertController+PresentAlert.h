//
//  UIAlertController+PresentAlert.h
//  MeridianiOSControls
//
//  Created by Stephen Kelly on 8/28/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (MRDPresentAlert)
/// Attempt to present the alert on the key window's top most view controller
+ (void)mrd_presentAlert:(nonnull UIAlertController *)alert;
/// Attempt to present an alertView style alert with the given title/message/button-title
+ (void)mrd_presentAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message button:(nonnull NSString *)button;
/// Attempt to present an alertView style alert with the given title/message and OK as the default button
+ (void)mrd_presentOKAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
@end
