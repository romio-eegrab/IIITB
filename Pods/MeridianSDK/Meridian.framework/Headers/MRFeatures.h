//
//  MRFeatures.h
//  Meridian
//
//  Copyright (c) 2017 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Object for holding which features are enabled
/// for a given Editor Location
@interface MRFeatures : NSObject
/// Maps feature enabled
@property (nonatomic, readonly) BOOL maps;
/// Blue Dot feature enabled
@property (nonatomic, readonly) BOOL bluedot;
/// Asset Tracking feature enabled
@property (nonatomic, readonly) BOOL tags;
/// Campaigns feature enabled
@property (nonatomic, readonly) BOOL campaigns;
/// AppMaker feature enabled
@property (nonatomic, readonly) BOOL appmaker;

/// Load the features for the most recently loaded location
/// @return MRFeatures object representing the features available for that location if they're available
+ (nullable MRFeatures *)featuresForCurrentApp;

/// Load the features for a given location
/// @param app MREditorKey of the location to load the features for
/// @return MRFeatures object representing the features available for that location
+ (MRFeatures *)featuresForApp:(MREditorKey *)app;

/// Register a features dictionary for a given location key
/// @param features Dictionary representation of the MRFeatures
/// @param app      MREditorKey for the location
+ (void)registerFeaturesDictionary:(NSDictionary *)features forApp:(MREditorKey *)app;

/// Register an `MRFeatures` object for a given location
/// @param features MRFeatures enabled for the location
/// @param app      MREditorKey for the location
+ (void)registerFeatures:(MRFeatures *)features forApp:(MREditorKey *)app;
NS_ASSUME_NONNULL_END

@end
