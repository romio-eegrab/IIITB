//
//  MRIntroPage.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 7/21/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRDIntroPage : NSObject <NSCopying>
/// Image to display in the top/header position
@property (nullable, nonatomic, copy) UIImage *image;
/// String/Copy to show in the intro view
@property (nonnull, nonatomic, copy) NSString *title;
/// Optional button title to show. If set, a button will be added
/// Will apply the default attributes of white text & body style text
@property (nullable, nonatomic, copy) NSString *buttonTitle;
/// Optional attributed button title to show. If set, a button will be added.
@property (nullable, nonatomic, copy) NSAttributedString *attributedButtonTitle;

/// Create an MRIntroPage with a given image and title
/// @param image Header/Hero image to show
/// @param title Text to show on the intro page
+ (nonnull instancetype)introPageWithImage:(nullable UIImage *)image title:(nonnull NSString *)title;

/// Create an MRIntroPage with a given image and title
/// @param image       Header/Hero image to show
/// @param title       Text to show on the intro page
/// @param buttonTitle Button title text to show with default attributes
+ (nonnull instancetype)introViewWithImage:(nullable UIImage *)image title:(nonnull NSString *)title buttonTitle:(nullable NSString *)buttonTitle;

/// Create an MRIntroPage with a given image and title
/// @param image                 Header/Hero image to show
/// @param title                 Text to show on the intro page
/// @param attributedButtonTitle Attributed button title to use
+ (nonnull instancetype)introViewWithImage:(nullable UIImage *)image title:(nonnull NSString *)title attributedButtonTitle:(nullable NSAttributedString *)attributedButtonTitle;
@end
