//
// NSError+Helpers.h
// Meridianapps
//


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MeridianErrorCode) {
    /// Bluetooth is currently powered off
MeridianErrorCodeBluetoothTurnedOff = 7001,
/// Directions are currently calculating
MeridianErrorCodeDirectionsCalculating = 1001,
/// Directions Request was cancelled
MeridianErrorCodeDirectionsRequestCancelled = 1002,
/// No prefix on location sharing request
MeridianErrorCodeFriendsMissingInvitationPrefix = 2001,
/// No friend location
MeridianErrorCodeFriendsMissingLocation = 2002,
/// Invalid map size provided
MeridianErrorCodeInternalMapSizeInvalid = 8001,
/// Error loading the map surface
MeridianErrorCodeInternalMapSurfaceError = 8002,
/// Multiple Monitoring Managers
MeridianErrorCodeInternalMultipleMonitoringManagers = 8003,
/// Maximum number of request retries reached
MeridianErrorCodeInternalNetworkMaxmimumRetriesReached = 8004,
/// 
MeridianErrorCodeInternalNetworkOperationCancelled = 8005,
/// Request is already in progress
MeridianErrorCodeInternalNetworkRequestInProgress = 8006,
/// No application token found for Meridian data requests
MeridianErrorCodeInternalNoApplicationToken = 8007,
/// Location request is missing from Info.plist
MeridianErrorCodeInternalRequestMissing = 8008,
/// Access to Location Services have been denied
MeridianErrorCodeLocationAccessDenied = 3001,
/// Access to Location Services are restricted
MeridianErrorCodeLocationAccessRestricted = 3002,
/// No location providers available
MeridianErrorCodeLocationNoProvidersAvailable = 3003,
/// Location fetch timout
MeridianErrorCodeLocationTimeout = 3004,
/// Unable to determine current location
MeridianErrorCodeLocationUnableToDetermineLocation = 3005,
/// Error loading the map
MeridianErrorCodeMapLoadError = 4001,
/// Incomplete data loaded
MeridianErrorCodeNetworkIncompleteDataFound = 5001,
/// No route found
MeridianErrorCodeRoutingNoRoute = 6001,
};

@interface NSError (Helpers)

/// Bluetooth is currently powered off
+ (nonnull instancetype)_bluetoothTurnedOff;
/// Directions are currently calculating
+ (nonnull instancetype)_directionsCalculating;
/// Directions Request was cancelled
+ (nonnull instancetype)_directionsRequestCancelled;
/// No prefix on location sharing request
+ (nonnull instancetype)_friendsMissingInvitationPrefix;
/// No friend location
+ (nonnull instancetype)_friendsMissingLocation;
/// Invalid map size provided
+ (nonnull instancetype)_internalMapSizeInvalid;
/// Error loading the map surface
+ (nonnull instancetype)_internalMapSurfaceError;
/// Multiple Monitoring Managers
+ (nonnull instancetype)_internalMultipleMonitoringManagers;
/// Maximum number of request retries reached
+ (nonnull instancetype)_internalNetworkMaxmimumRetriesReached;
/// 
+ (nonnull instancetype)_internalNetworkOperationCancelled;
/// Request is already in progress
+ (nonnull instancetype)_internalNetworkRequestInProgress;
/// No application token found for Meridian data requests
+ (nonnull instancetype)_internalNoApplicationToken;
/// Location request is missing from Info.plist
+ (nonnull instancetype)_internalRequestMissing;
/// Access to Location Services have been denied
+ (nonnull instancetype)_locationAccessDenied;
/// Access to Location Services are restricted
+ (nonnull instancetype)_locationAccessRestricted;
/// No location providers available
+ (nonnull instancetype)_locationNoProvidersAvailable;
/// Location fetch timout
+ (nonnull instancetype)_locationTimeout;
/// Unable to determine current location
+ (nonnull instancetype)_locationUnableToDetermineLocation;
/// Error loading the map
+ (nonnull instancetype)_mapLoadError;
/// Incomplete data loaded
+ (nonnull instancetype)_networkIncompleteDataFound;
/// No route found
+ (nonnull instancetype)_routingNoRoute;

/// Create a NSError with a given error code and specified userInfo dictionary
/// @param code     `MeridianErrorCode` of the error
/// @param userInfo Optional UserInfo dictionary to associate with the error
+ (nonnull instancetype)mrd_errorWithMeridianErrorCode:(MeridianErrorCode)code userInfo:(nullable NSDictionary *)userInfo;

@end

// Call this empty method to include this category-only object file in your binary without needed the -ObjC flag.
void NSErrorHelpersInclude(void);
