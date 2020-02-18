//
//  UITabBarController+HideShow.h
//  MeridianiOSControls
//
//  Created by Cody Garvin on 8/25/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Adds the ability to hide and show the tab bar with an animation. This actually 
 grows and shrinks the frame in order to create the illusion the tab bar is 
 showing and hiding.
 */
@interface UITabBarController (HideShow)

/// The original frame before it is adjusted to hide the tab bar.
@property (nonatomic) CGRect originalFrameView;
/// The new frame after it is adjusted to hide the tab bar.
@property (nonatomic) CGRect movedFrameView;


/**
 Call this method to show and hide the tab bar.

 @param visible If the tab bar should be visible or hidden
 @param animated If the tab bar showing or hiding should be animated or not. .3 
 seconds is the default time.
 */
- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated;
@end
