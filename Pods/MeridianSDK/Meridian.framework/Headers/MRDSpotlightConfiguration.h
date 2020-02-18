//
//  MRSpotlightConfiguration.h
//  Meridian
//
//  Created by Daniel Miedema on 6/12/18.
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRDSpotlightConfiguration : NSObject <NSCopying>

/// Array of Location IDs to index
@property (nonatomic, nonnull, readonly, copy) NSArray <NSString *> *locationIDs;

/// Boolean for if we should delete the currently index data.
/// Default value is `NO`
@property (nonatomic, readonly, assign) BOOL deletedIndexedData;

/// Create an MRSpotlightConfiguration with a given
/// array of location IDs to index
/// @param locationIDs       array of location IDs to index
/// @param deleteIndexedData bool for if we should delete our currently indexed data before indexing `locationIDs`
+ (nonnull instancetype)spotlightConfigurationWithLocationIDs:(nonnull NSArray <NSString *> *)locationIDs deleteIndexedData:(BOOL)deleteIndexedData;
@end

NS_ASSUME_NONNULL_END
