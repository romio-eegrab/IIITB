//
//  MRDFormDataSource.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 9/25/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRDFormRowProtocol;
@protocol MRDFormSectionProtocol;

@interface MRDFormDataSource : NSObject
/// Current values as an array of dictionaries.
/// Each index in the array corresponds to a section in the form.
/// where the keys are the row titles and the value is the current value
/// for that row.
@property (nonatomic, nonnull, copy) NSArray <NSDictionary <NSString *, id> *> *data;

/// Check and see if we've made any changes to our row values
@property (nonatomic, readonly) BOOL hasChanges;

/// Current Sections.
@property (nonatomic, nonnull, readonly, copy) NSArray <MRDFormSectionProtocol> *sections;

/// Default row height for all rows excluding text view that
/// would require more height to display all their content.
/// Default value is `74`
@property (nonatomic, assign) CGFloat defaultRowHeight;

/// Access a current section at a given index. If the index is out
/// of bounds this will return `nil` instead of throwing an exception
/// @param index `NSUInteger` index of the desired section
/// @return MRDFormSectionProtocol if a section exists at that index, `nil` otherwise
- (nullable NSObject<MRDFormSectionProtocol> *)sectionAtIndex:(NSUInteger)index;

/// Insert a section at an arbitrary index. If the index is out of
/// bounds the section will be inserted at the end
/// @param section Section to insert
/// @param index   Index to insert the section at
- (void)insertSection:(nonnull NSObject<MRDFormSectionProtocol> *)section atIndex:(NSUInteger)index;

/// Remove a section at a given index.
/// If no section exists at the specified index, nothing happens.
/// @param index Index of the section to remove
- (void)removeSetionAtIndex:(NSUInteger)index;

/// Create a form datasource with a given set of sections
/// @param tableView UITableView to be the datasource/delegate for
/// @param sections  Array of Sections to create the data source with
/// @return new Datasource with the sections
+ (nonnull instancetype)dataSourceWithTableView:(nonnull UITableView *)tableView sections:(nonnull NSArray <NSObject<MRDFormSectionProtocol> *> *)sections;

/// Create a form datasource with a given set of sections
/// @param tableView UITableView to be the datasource/delegate for
/// @param sections  Array of Sections to create the data source with
/// @return new Datasource with the sections
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView sections:(nonnull NSArray <NSObject<MRDFormSectionProtocol> *> *)sections NS_DESIGNATED_INITIALIZER;

/// Calling `init` is not available.
/// Use `-initWithTableView:sections:` instead
- (nonnull instancetype)init NS_UNAVAILABLE;
@end
