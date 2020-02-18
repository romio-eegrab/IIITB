//
//  MRTagManager.h
//  Meridian
//
//  Copyright © 2016 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Meridian/MRTag.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MRTagManagerDelegate;
@protocol MRDTagSubscription;

/**
 * NSDictionary
 */

@interface NSDictionary (MRDMergedDictionary)

/**
 * Get our dictionary combined the values from another dictionary
 *
 * @param dictionary  The source dictionary
 */
- (instancetype)mrd_addingValuesFromDictionary:(nonnull NSDictionary *)dictionary;

@end

/**
 * MRTagManager
 */

@interface MRTagManager : NSObject

/// The location ID to use for the tag subscriptions
@property (nonnull, nonatomic, copy) NSString *locationID;

/// Tag subscriptions to subscribe to
@property (nonatomic, nullable, copy) NSArray <id<MRDTagSubscription>> *tagSubscriptions;

/// The delegate to receive event callbacks.
@property (nullable, nonatomic, weak) id<MRTagManagerDelegate> delegate;

- (void)startUpdatingTags;
- (void)stopUpdatingTags;

/**
 * Create an MRTagManager for a given location with a specified delegate
 *
 * @param locationID The location
 * @param delegate MRTagManagerDelegate
 */
+ (instancetype)tagManagerForLocationID:(nonnull NSString *)locationID
                               delegate:(nullable id<MRTagManagerDelegate>)delegate;

@end

/**
 *  Delegate methods for MRTagManager.
 */
@protocol MRTagManagerDelegate <NSObject>

@optional

- (void)tagManager:(MRTagManager *)manager didLoadTags:(NSArray <MRTag *> *)tags;
- (void)tagManager:(MRTagManager *)manager didUpdateTag:(MRTag *)tag;
- (void)tagManager:(MRTagManager *)manager didRemoveTag:(MRTag *)tag;

NS_ASSUME_NONNULL_END

@end
