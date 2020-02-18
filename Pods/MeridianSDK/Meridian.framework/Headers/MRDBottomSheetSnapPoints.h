//
//  MRDBottomSheetSnapPoints.h
//  MeridianiOSControls
//
//  Created by Alex Belliotti on 2/26/19.
//  Copyright © 2019 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Expresses the bottom sheet 'snap' points.
/// Minimum height is expressed by the MRDBottomSheetAbstractController's minimumHeight property.
@interface MRDBottomSheetSnapPoints : NSObject

@property (nonatomic, assign) CGFloat maximumHeight;
@property (nonatomic, assign) CGFloat middleHeight;
/// See also MRDBottomSheetAbstractController's startsHidden property.
@property (nonatomic, assign) CGFloat hiddenHeight;

@end

NS_ASSUME_NONNULL_END
