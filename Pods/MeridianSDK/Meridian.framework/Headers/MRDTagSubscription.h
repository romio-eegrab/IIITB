//
//  MRDTagSubscription.h
//  Meridian
//
//  Created by miedema on 8/9/18.
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

@protocol MRDTagSubscription <NSObject>
/// Identifier to subscribe to. Should probably be the `value` for
/// whatever key we need in our `subscribeKey` dictionary
@property (nonatomic, nonnull, copy) NSString *identifier;

/// The key to return for this subscription type.
/// Should be compatible with the socket's required `subscribe` format
@property (nonatomic, nonnull, readonly, copy) NSDictionary <NSString *, NSString *> *subscribeKey;

/// Create a tag subscription with a given identifier
+ (nonnull instancetype)subscriptionWithIdentifier:(nonnull NSString *)identifier;

/// Initialize with a given identifier
- (nonnull instancetype)initWithIdentifier:(nonnull NSString *)identifier;
@end
