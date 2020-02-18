//
//  MRDPlacemarkDetails.h
//  Meridian
//
//  Created by Cody Garvin on 9/7/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import "MRPlacemark.h"


/**
 The format of a placemark image layout.
 */
typedef NS_ENUM(NSInteger, MRDPlacemarkImageLayout) {
    
    /// An image will fill edge to edge filling the entire imageview.
    MRDPlacemarkImageLayoutWidescreen,
    /// An image will allow white space on the sides in order to fit the height of the imageview.
    MRDPlacemarkImageLayoutFullPage,
};

@interface MRDPlacemarkDetails : MRPlacemark

+ (instancetype)placemarkWithJSON:(NSDictionary *)json map:(MREditorKey *)mapKey;
+ (instancetype)placemarkWithJSON:(NSDictionary *)json app:(MREditorKey *)appKey;
@property (nonatomic, readonly) CGSize imageSize;
@property (nonatomic, readonly) MRDPlacemarkImageLayout imageLayout;
@property (nonatomic, readonly) NSString *descriptionString;
@property (nonatomic, readonly) NSAttributedString *attributedDescriptionString;
@property (nonatomic, readonly) NSArray *linkStubs;

// Loaded separately
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSArray *clones;
@property (nonatomic, strong) NSArray *eventLinks;
@property (nonatomic, strong) NSArray *linkAndLinkStubs;

@end
