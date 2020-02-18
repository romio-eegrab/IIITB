//
//  MRDTagSubscriptionImpl.h
//  Meridian
//
//  Created by miedema on 8/9/18.
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Meridian/MRDTagSubscription.h>

NS_ASSUME_NONNULL_BEGIN

/// Default implementation for ease of subclassing.
/// Provides default implementation for initializer methods
/// so subclasses can just provide a proper `subscribeKey` property
@interface MRDTagSubscriptionImpl : NSObject <MRDTagSubscription>
@end

NS_ASSUME_NONNULL_END
