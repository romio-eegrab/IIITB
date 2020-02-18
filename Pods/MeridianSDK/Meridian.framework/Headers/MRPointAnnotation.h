//
//  MRPointAnnotation.h
//  Meridian
//
//  Copyright (c) 2016 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Meridian/MRAnnotation.h>

NS_ASSUME_NONNULL_BEGIN

/** 
 * An annotation residing at a particular point on a map. Implements all properties of MRAnnotation protocol.
 */
@interface MRPointAnnotation : NSObject<MRAnnotation>

@property (nonatomic, assign) CGPoint point;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) MRZoomLevel minimumZoomLevel; // default MRZoomLevelWorld
@property (nonatomic, assign) MRZoomLevel maximumZoomLevel; // default MRZoomLevelAtom

- (instancetype)initWithPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
