//
//  MRLocalSearch.h
//  Meridian
//
//  Copyright (c) 2016 Aruba Networks. All rights reserved.
//

#import <Meridian/MRLocalSearchRequest.h>
#import <Meridian/MRPlacemarkResponse.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The block to use for processing the result of a search.
 */
typedef void (^MRLocalSearchCompletionHandler)(MRPlacemarkResponse * _Nullable response, NSError * _Nullable error);

/**
 * Describes a search to be performed on Meridian servers. After configuring the search, you call `startWithCompletionHandler:`
 * to asynchonously perform the search.
 */

@interface MRLocalSearch : NSObject

/// Returns `YES ` if the search is currently being performed.
@property (nonatomic, readonly, getter=isSearching) BOOL searching;

/**
 * The designated initializer. The request will be copied during initialization, so any changes made to the request
 * after this method returns do not affect the request used in `startWithCompletionHandler:`.
 *
 * @param request  The request object containing the details of this search.
 */
- (nullable instancetype)initWithRequest:(MRLocalSearchRequest *)request;

/**
 * Starts the asynchronous search operation. 
 *
 * Any calls to `startWithCompletionHandler:` while `[MRLocalSearch isSearching]` will fail.
 * The `completionHandler` block will be called on the main queue and takes two parameters:
 *
 *      - `response` contains the search results, or `nil` if an error occurred.
 *      - `error` contains the error information if one occured, or `nil` if the search was successful.
 *
 * @param completionHandler  A block to run when the search finishes.
 */
- (void)startWithCompletionHandler:(MRLocalSearchCompletionHandler _Nullable)completionHandler;

/**
 * Cancels the search.
 */
- (void)cancel;

NS_ASSUME_NONNULL_END
@end
