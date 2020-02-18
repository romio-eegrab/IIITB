//
//  UIImage+ColorSize.h
//  MRDBottomSheet
//
//  Created by Cody Garvin on 7/11/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MRDColorSize)


/**
 Resizes an image to have padding so that text can align correctly in places 
 like UITableCells. This way all icons can have various widths for different 
 places, yet still work in areas that need consistency in width.

 @param paddingWidth The width the image should be resized to.
 @param color The color the image should be overlayed with.
 @return Returns an image resized and colored.
 */
- (nonnull UIImage *)mrd_imageWithWidthPadding:(CGFloat)paddingWidth
                                     theme:(nullable UIColor *)color;

@end
