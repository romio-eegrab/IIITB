//
//  MRDControlsLocalizedString.h
//  MeridianiOSControls
//
//  Created by Stephen Kelly on 1/11/18.
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

// Class used to access the local bundle
@interface MRDControlsLocalizedString : NSObject
@end

// Use this macro to access Localizable.strings translations in the MeridianiOSControls framework
#define MRDControlsLocalizedString(key, comment) NSLocalizedStringFromTableInBundle(key, nil, [NSBundle bundleForClass:MRDControlsLocalizedString.class], comment)
