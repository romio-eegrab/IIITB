//
//  MRDSearchProtocols.h
//  Meridian
//
//  Created by Alex Belliotti on 2/27/19.
//  Copyright © 2019 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MRDSheetSearchProtocols_h
#define MRDSheetSearchProtocols_h

typedef NS_ENUM(NSInteger, MRDSheetSearchResultsType) {
    MRDSheetSearchResultsTypeSearch,            // regular search results or recent item
    MRDSheetSearchResultsTypeShortcut,          // amenity/facility/shortcut buttons depending what the term of the day is
    MRDSheetSearchResultsTypeSearchNearby,      // search nearby cell
    MRDSheetSearchResultsTypeShow               // show arbitrary results given to us by MRDSheetSearchContainer's showResults:
};

@class MREditorKey, MRDSheetSearchContainerViewController, MRDSheetSearchResultsTableViewController, MRPlacemark;
@class MRDSheetSearchRecentsTableViewController, MRDSheetSearchAmenityItem;

NS_ASSUME_NONNULL_BEGIN

@protocol MRDSearchResultDisplayable <NSObject>

@required
/// this should NOT be used to determine location, as it may not be a real key (since we conflate mac/key on tags in particular)
- (nullable MREditorKey *)key;
- (NSString *)searchTitleText;
- (nullable UIImage *)searchIcon;
- (UIColor *)searchIconFillColor;
- (UIColor *)searchIconTintColor;
/// some displayables may not have an associated map location (whitelabel page links, for example)
- (nullable NSString *)mapKeyIdentifier;

@optional
- (NSString *)searchSubText;
/// an alternative identifier to an editor key
- (NSString *)searchUniqueIdentifier;
/// the x,y coordinate the result lives in on the map as a CGPoint wrapped in an NSValue.  null if a valid mapPoint
/// cannot be determined.
- (nullable NSValue *)mapPoint;

/// some displayables have a distance to the user, always in meters.
- (nullable NSNumber *)distanceToUser;

@end

@protocol MRDSheetSearchDelegate <NSObject>

- (BOOL)sheetSearch:(MRDSheetSearchContainerViewController *)searchContainerViewController
   didSelectResults:(NSArray<MRDSearchResultDisplayable> *)results
             ofType:(MRDSheetSearchResultsType)type;

@end

@protocol MRDSheetSearchResultTableViewControllerDelegate <NSObject>

- (void)resultsTableViewController:(UITableViewController *)viewController
                  didSelectResults:(NSArray<MRDSearchResultDisplayable> *)results
                            ofType:(MRDSheetSearchResultsType)type;
- (void)resultsTableViewControllerRetryTapped:(UITableViewController *)viewController;
- (void)clearSearch;

@end

@protocol MRDSheetSearchRecentsTableViewControllerDelegate <MRDSheetSearchResultTableViewControllerDelegate>

- (void)recentsTableViewController:(UITableViewController *)viewController didSelectAmenity:(MRDSheetSearchAmenityItem *)item;

@end

@protocol MRDSheetSearchContentViewController <NSObject>

@required
@property (nullable, nonatomic, strong) NSArray<NSLayoutConstraint *> *pinningConstraints;

@end

NS_ASSUME_NONNULL_END

#endif
