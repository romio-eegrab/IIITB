//
//  UIFont+MRDFormView.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/27/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (MRDFormView)
/// Get our preferred title font
@property (class, nonatomic, readonly, nonnull, copy) UIFont *mrd_titleFont;

/// Open Sans Font
@property (class, nonatomic, readonly, nonnull, copy) UIFont *mrd_openSans;

/// Open Sans SemiBold Font
@property (class, nonatomic, readonly, nonnull, copy) UIFont *mrd_openSansSemiBold;

/// Open Sans Bold Font
@property (class, nonatomic, readonly, nonnull, copy) UIFont *mrd_openSansBold;

/// Open Sans Regular Italic Font
@property (class, nonatomic, readonly, nonnull, copy) UIFont *mrd_openSansItalic;

/// Open Sans Bold Italic Font
@property (class, nonatomic, readonly, nonnull, copy) UIFont *mrd_openSansBoldItalic;

/// Inconsolata Font
@property (class, nonatomic, readonly, nonnull, copy) UIFont *mrd_inconsolata;

/// Get a dynamic font with specified UIFont instance and specified style.
/// @param font The UIFont to use
/// @param style the `UIContentSizeCategory` string constant
/// @return Dynamically sized font.
+ (nonnull UIFont *)mrd_dynamicFont:(nonnull UIFont *)font withTextStyle:(nonnull NSString *)style;
@end

