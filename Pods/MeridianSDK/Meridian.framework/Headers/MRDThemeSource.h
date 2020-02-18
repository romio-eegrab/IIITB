//
//  MRDThemeSource.h
//  MeridianiOSControls
//
//  Created by Cody Garvin on 8/15/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#ifndef MRDThemeSource_h
#define MRDThemeSource_h

NS_ASSUME_NONNULL_BEGIN

/**
 Provides the interface to which themes should adhere to. It is necessary to be
 a singleton for easy access, as it is globally used much like UIAppearance.
 */
@protocol MRDThemeSource <NSObject>

/// The current theme instance. This allows ability to slipstream a theme in via
/// singleton.
+ (instancetype)sharedTheme;

/// The main theme color. Applied to images, accessory views, buttons, etc.
@property (nonatomic, copy, readonly) UIColor *primaryColor;

/// The additional theme color for subtext and certain call outs.
@property (nonatomic, copy, readonly) UIColor *secondaryColor;

/// Background meet color, color meet background.
@property (nonatomic, copy, readonly) UIColor *backgroundColor;

@optional

/**
 Set any global UIAppearance settings and default theme colors with this
 implementation. This can be applied to the singleton in this case as well.
 
 @param theme an instance of MRDThemeSource protocol that already has a theme
 set.
 */
- (void)applyTheme:(nullable id<MRDThemeSource>)theme;

/**
 Ability to create a theme from JSON. Choice of conversion is up to the implementor.
 
 @param json A dictionary of key value pairs to convert into colors or other
 attributes.
 */
- (instancetype)initWithJSON:(nonnull NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END

#endif /* MRDThemeDelegate_h */
