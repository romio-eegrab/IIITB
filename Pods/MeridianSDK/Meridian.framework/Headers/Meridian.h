//
//  MeridianiOS.h
//  MeridianiOS
//
//  Created by Cody Garvin on 10/25/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MeridianiOS.
FOUNDATION_EXPORT double MeridianiOSVersionNumber;

//! Project version string for MeridianiOS.
FOUNDATION_EXPORT const unsigned char MeridianiOSVersionString[];

/// ----

// In this header, you should import all the public headers of your framework using statements like #import <Meridian/PublicHeader.h>


#import <UIKit/UIKit.h>

#import <Meridian/MRConfig.h>
#import <Meridian/MRLocation.h>
#import <Meridian/MRLocationManager.h>
#import <Meridian/MRCampaignManager.h>
#import <Meridian/MREditorKey.h>
#import <Meridian/MRMap.h>
#import <Meridian/MRMapView.h>
#import <Meridian/MRPlacemark.h>
#import <Meridian/MRPlacemarkRequest.h>
#import <Meridian/MRPlacemarkResult.h>
#import <Meridian/MRQueryFilter.h>
#import <Meridian/MRFriend.h>
#import <Meridian/MRSharingSession.h>
#import <Meridian/MRFriendAnnotationView.h>
#import <Meridian/MRInvite.h>
#import <Meridian/MRTag.h>
#import <Meridian/MRTagManager.h>
#import <Meridian/MRDTagSubscription.h>
#import <Meridian/MRTagAnnotationView.h>
#import <Meridian/MRAnnotation.h>
#import <Meridian/MRPointAnnotation.h>
#import <Meridian/MRUserLocation.h>
#import <Meridian/MRAnnotationView.h>
#import <Meridian/MRPlacemarkAnnotationView.h>
#import <Meridian/MRDPlacemarkDetails.h>
#import <Meridian/MRMapViewController.h>
#import <Meridian/MRDirections.h>
#import <Meridian/MRDirectionsTypes.h>
#import <Meridian/MRDirectionsRequest.h>
#import <Meridian/MRDirectionsResponse.h>
#import <Meridian/MRLocalSearch.h>
#import <Meridian/MRSearchRequest.h>
#import <Meridian/MRSearch.h>
#import <Meridian/MRPathOverlay.h>
#import <Meridian/MRPathRenderer.h>
#import <Meridian/MeridianErrors.h>
#import <Meridian/NSString+HTML.h>
#import <Meridian/MRDAction.h>
#import <Meridian/MRFeatures.h>
#import <Meridian/MRLog.h>
#import <Meridian/MRResources.h>
#import <Meridian/UIWindow+VisibleViewController.h>
#import <Meridian/MRDDirectionsAssistantProtocol.h>
#import <Meridian/NSDate+PrettyString.h>
#import <Meridian/NSDictionary+Meridian.h>
#import <Meridian/MRDSpotlightConfiguration.h>
#import <Meridian/MRDSupportedTagSubscriptions.h>
#import <Meridian/MRDBottomSheetDetailsDataSource.h>
#import <Meridian/MRDSheetSearchProtocols.h>
#import <Meridian/MRDClusteredAnnotation.h>
#import <Meridian/MRPlacemarkInflatedAnnotationView.h>
#import <Meridian/MRDClusteredAnnotationView.h>

#ifndef SKIP_IOS_CONTROLS
#import <Meridian/MeridianiOSControls.h>
#import <Meridian/MRDTextField.h>
#import <Meridian/MRDTextView.h>
#import <Meridian/UITableViewCell+MRDFormView.h>
#import <Meridian/MRDView.h>
#import <Meridian/MRDIntroPage.h>
#import <Meridian/MRDIntroPageView.h>
#import <Meridian/TTTAttributedLabel.h>
#import <Meridian/MRDControlsLocalizedString.h>
#import <Meridian/MRDFormCustomTableViewCell.h>
#import <Meridian/MRDFormSegmentControlTableViewCell.h>
#import <Meridian/MRDFormSubtitleTableViewCell.h>
#import <Meridian/MRDFormSwitchTableViewCell.h>
#import <Meridian/MRDFormTextFieldTableViewCell.h>
#import <Meridian/MRDFormTextViewTableViewCell.h>
#import <Meridian/MRDImageTableViewCell.h>
#endif

// Version
#define MERIDIAN_VERSION @"5.10.0"

extern CGFloat MRSnapToRouteDistance; // meters

/// Minimum RSSI value to trigger a campaign.
/// Set to `nil` to remove the minimum threshold.
extern NSNumber *_Nullable MRMinimumRSSIForCampaignTrigger;
