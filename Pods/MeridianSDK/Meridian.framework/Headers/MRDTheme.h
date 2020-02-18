//
//  MRDTheme.h
//  MeridianiOSControls
//
//  Created by Cody Garvin on 10/16/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRDThemeSource.h"

@interface MRDTheme : NSObject <MRDThemeSource>

+ (nonnull UIColor *)directionsGray;

@property (class, nonatomic, nonnull, readonly, copy) UIColor *directionsOverviewLightGray;
@end
