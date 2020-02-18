#import <UIKit/UIKit.h>

/// Provides access to resources in Meridian.bundle. Thread-safe.
@interface MRResources : NSObject
NS_ASSUME_NONNULL_BEGIN

/// Returns the resources bundle
+ (NSBundle *)bundle;

/// Searches inside Meridian.bundle. Assumes png extension if not specified.
/// @param name The name of the image.
+ (UIImage * _Nullable)imageNamed:(NSString *)name;

// Performs image size checks
+ (UIImage *)mapTextureNamed:(NSString *)name;
+ (UIImage *)mapIconNamed:(nonnull NSString *)name;
+ (UIImage *)mapIconNamed:(nonnull NSString *)name forSize:(CGSize)size;
+ (UIImage *)mapIconNamed:(nonnull NSString *)name forSize:(CGSize)size withColor:(nullable UIColor *)color;

/// Icon font support
+ (NSString *)iconFontName;
+ (NSString *)iconStringForPlacemarkType:(nullable NSString *)placemarkType;

+ (UIColor *)arubaColor;

/// Register an image for a given key
/// @param image An image presented for registration.
/// @param key The key associated with a particular image.
+ (void)registerImage:(nonnull UIImage *)image forKey:(nonnull NSString *)key;
/// Get the image for a key if it exists
/// @param key The key associated with a particular (returned) image.
+ (nullable UIImage *)imageForKey:(nonnull NSString *)key;
/// Check if we have an image for a given key
/// @param key A key which may or may not be associated with an image.
+ (BOOL)hasImageForKey:(nonnull NSString *)key;

/// Register some data for a given key
/// @param data Data presented for registration with a particular key
/// @param key The key associated with a particular blob of data.
+ (void)registerData:(nonnull NSData *)data forKey:(nonnull NSString *)key;
/// Get the data for a key if it exists
/// @param key The key associated with a particular (returned) data blob.
+ (nullable NSData *)dataForKey:(nonnull NSString *)key;
/// Check if we have some data for a given key
/// @param key A key which may or may not be associated with a data blob.
+ (BOOL)hasDataForKey:(nonnull NSString *)key;
NS_ASSUME_NONNULL_END
@end
