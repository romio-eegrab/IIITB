//
//  MRDClusteredAnnotation.h
//  Meridian
//
//  Created by Alex Belliotti on 4/30/19.
//  Copyright © 2019 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Meridian/MRAnnotation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Transient annotation that is created by MRMapView's implementation when MRMapView's shouldClusterHighlightedAnnotations
 flag is set to YES.
 */
@interface MRDClusteredAnnotation : NSObject <MRAnnotation>

@property (nonatomic, strong, readonly) id<MRAnnotation> winner; // determines cluster position
@property (nonatomic, strong, readonly) NSArray<MRAnnotation> *annotations; // contains winner as well

// MRAnnotation

@property (nonatomic, assign) CGPoint point;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) MRZoomLevel minimumZoomLevel;
@property (nonatomic, assign, readonly) MRZoomLevel maximumZoomLevel;
@property (nonatomic, assign, readonly) CGFloat zPosition;
@property (nonatomic, assign, readonly) BOOL collides;

- (instancetype)initWithAnnotations:(NSArray<MRAnnotation> *)annotations;

@end

NS_ASSUME_NONNULL_END
