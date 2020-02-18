//
//  MRDBottomSheetDetailsDataSource.h
//  MeridianiOSControls
//
//  Created by Cody Garvin on 7/31/18.
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 Base abstract class for creating a data source for a bottom sheet table. This
 allows to create an instance of MRDMapPlacemarkViewController and alter the
 cell content in the table by replacing the data source with a child of
 MRDBottomSheetDetailsDataSource.
 */
@interface MRDBottomSheetDetailsDataSource : NSObject <UITableViewDataSource>

/// An image to display at the top of the tableview if given. Note that this will
/// always set the image to the top of the bottomSheetTableData. Use the flag
/// imageAlwaysOnTop set to NO if it does not matter where the image appears.
@property (nonatomic, nullable, strong) UIImage *heroImage;

/// The contentmode that will be applied to the imageview that contains the
/// heroImage. Defaults to UIViewContentModeScaleAspectFill. Advised to set
/// the heroImageContentMode before setting the heroImage as to not have a sudden
/// change in display of the image.
@property (nonatomic, assign) UIViewContentMode heroImageContentMode;

/// The data for the sheet table to be used via inheritance. Takes into consideration
/// the heroImage being set. If there is an image set and the bottomSheetTableData
/// receives new data, the image will be placed according to  the flag `imageAlwaysOnTop`.
/// Set heroImage to nil if it is desired to no longer to be in bottomSheetTableData.
@property (nonatomic, strong, nullable) NSArray *bottomSheetTableData;

/// Used to dictate placement of the image. By default the image will always be
/// the first row. Set this to NO to place it when it loads. This could be random
/// depending on how the rest of the dataset is retrieved.
@property (nonatomic, assign) BOOL imageAlwaysOnTop;

/// Generic delegate callback that adheres to MRDPlacemarkSheetDataSourceDelegate
/// for callbacks when something is tapped. Passed through to the concrete class.
@property (nonatomic, nullable, weak) id callbackDelegate;

@end

NS_ASSUME_NONNULL_END
