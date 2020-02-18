//
//  MRDFormViewProtocols.h
//  MeridianiOSControls
//
//  Created by Cody Garvin on 10/11/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#ifndef MRDFormViewProtocols_h
#define MRDFormViewProtocols_h

typedef NS_ENUM(NSUInteger, MRDFormRowType) {
    /// Subtitle type row, Main label row with label underneath
    MRDFormRowTypeSubtitle,
    /// Row with a text field. Designed for short, single line inputs
    MRDFormRowTypeTextField,
    /// Row with a text field configured for password input.
    MRDFormRowTypePassword,
    /// Row with a text view. Designed for multiline input
    MRDFormRowTypeTextView,
    /// Row with a UISwitch
    MRDFormRowTypeSwitch,
    /// Row with a segmented control in it
    MRDFormRowTypeSegmentControl,
    /// Custom row type, delegate out to another object to provide data/layout/etc
    MRDFormRowTypeCustom,
};

@protocol MRDFormRowProtocol <NSObject>
/// Title value to use. Should be initialized as a *non localized* string.
/// When the title is displayed a call to `NSLocalizedString` will
/// be made on your behalf
@property (nonatomic, nonnull, readonly, copy) NSString *title;

/// Form row type
@property (nonatomic, readonly) MRDFormRowType type;

/// Initial value to show. For the various row types this should be
/// a different value. For Example:
/// @li `MRDFormRowTypeSubtitle` this should be an `NSString`
/// @li `MRDFormRowTypeTextField` this should be an `NSString`
/// @li `MRDFormRowTypeTextView` this should be an `NSString`
/// @li `MRDFormRowTypeTextSwitch` this should be a `BOOL` wrapped in an `NSNumber`
/// @li `MRDFormRowTypeTextSegementControl` this should be an `NSNumber` of selected segment index
@property (nonatomic, nullable, readonly, copy) id initialValue;

/// BOOL to determine if this row should be disabled or not
@property (nonatomic, assign) BOOL disabled;

/// Current value of the row
@property (nonatomic, nullable, readonly) id value;

/// BOOL for if this row should support swipe tp delete.
/// Default value is `NO`
@property (nonatomic, assign) BOOL canBeDeleted;

@optional
/// Placeholder value, used for `textField` and `textView` type rows
/// Can be either an NSString or NSAttributedString
@property (nonatomic, nullable, readonly, copy) id placeholderValue;

@end


@protocol MRDFormSectionProtocol <NSObject>
/// Rows for this section
@property (nonatomic, nonnull, copy) NSArray <MRDFormRowProtocol> *rows;
/// Optional Title to show for this section
@property (nonatomic, nullable, copy) NSString *title;

/// Data dictionary for this section.
/// The Keys are the row titles and the value is the value of
/// the corresponding row
@property (nonatomic, nonnull, copy, readonly) NSDictionary <NSString *, id> *data;

/// Get a specific row for a given identifier
/// @param identifier Row Title/identifier
/// @return `nil` if no row exists for that identifier. The `MRDFormRow` instance if one does.
- (nullable NSObject<MRDFormRowProtocol> *)rowForIdentifier:(nonnull NSString *)identifier;

@optional
/// Block to call when we have an attributed string value
/// Default block will just return `attributedString.string`
/// @param  attributedString NSAttributedString to transform
/// @return NSString that should somehow encode the string attributes.
@property (nonatomic, nullable, copy) NSString *_Nonnull(^attributedTextTransformBlock)(NSAttributedString *_Nonnull attributedString);

/// Block to call to transform/manipluate the `data` before returnning it
/// Can be used to flatten data out if mulitple values
/// are returned from a custom row and need to be placed at the top level
/// for example.
/// @param data value we're transforming
/// @return transformed data
@property (nonatomic, nullable, copy) NSDictionary<NSString *, id> *_Nonnull(^dataTransformBlock)(NSDictionary<NSString *, id> *_Nonnull data);

/// Block to call when a row has been deleted
/// @param section   MRDFormSection generating the delete
/// @param index     NSUInteger index of the deleted item
/// @param row       MRDFormRowProtocol item that was deleted
@property (nonatomic, nullable, copy) void(^deleteRowBlock)(NSObject<MRDFormSectionProtocol> *_Nonnull section, NSUInteger index, NSObject<MRDFormRowProtocol> *_Nonnull row);


/// Remove a row at a given index.
/// @note Requires `deleteRowBlock` to be implemented
- (void)removeRowAtIndex:(NSUInteger)index;

/// Insert a row at a given index
- (void)insertRow:(nonnull id<MRDFormRowProtocol>)row atIndex:(NSUInteger)index;
@end

#endif /* MRDFormViewProtocols_h */
