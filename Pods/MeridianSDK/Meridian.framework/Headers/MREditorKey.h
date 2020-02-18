//
//  MREditorKey.h
//  Meridian
//
//  Copyright (c) 2016 Aruba Networks. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * MREditorKey represents a globally-unique identifier to an object created in the Meridian Editor.
 * Objects created in the Editor can have multiple identifier components and this class helps locate
 * an object based on the various components needed.
 *
 * Here's an example: A Meridian "Placemark" has an identifier, but it is only unique to the parent Map
 * containing it. The Map also has an identifier, but it is only unique to the parent App containing it.
 * The App has its own identifier, which is globally unique, and so that is the root key with a 'nil' parent.
 *
 * Putting it all together:
 *
 * placemarkKey.identifier = Placemark ID
 * placemarkKey.parent.identifier = Map ID
 * placemarkKey.parent.parent.identifier = App ID
 *
 */

NS_ASSUME_NONNULL_BEGIN

@interface MREditorKey : NSObject <NSCopying, NSSecureCoding>

/// The string identifier of this object.
@property (nonatomic, readonly, copy) NSString *identifier;

/// A key representing the parent of this object. May be nil.
@property (nullable, nonatomic, readonly, copy) MREditorKey *parent;

/**
 * Creates and returns a key with the provided identifier.
 *
 * @param identifier  A string that uniquely identifies this object.
 */
+ (MREditorKey *)keyWithIdentifier:(NSString *)identifier;

/**
 * Creates and returns a key with the provided identifier and parent.
 *
 * @param identifier  A string that uniquely identifies this object.
 * @param parent  A key that identifies the parent of this object.
 */
+ (MREditorKey *)keyWithIdentifier:(NSString *)identifier parent:(MREditorKey *)parent;

- (BOOL)isEqualToKey:(nullable MREditorKey *)key;

@end

//
// Some helpful category methods to construct keys to known objects using known identifiers.
//

@interface MREditorKey (ConcreteForms)

+ (MREditorKey *)keyForMap:(NSString *)mapIdentifier app:(NSString *)appIdentifier;
+ (MREditorKey *)keyForPlacemark:(NSString *)placemarkIdentifier map:(MREditorKey *)mapKey;

@end

NS_ASSUME_NONNULL_END
