#import <UIKit/UIKit.h>

// Provides access to resources in Meridian.bundle. Thread-safe.
@interface MRDResources : NSObject
NS_ASSUME_NONNULL_BEGIN

// Returns the resources bundle
+ (NSBundle *)bundle;

// Searches inside Meridian.bundle. Assumes png extension if not specified.
+ (UIImage * _Nullable)imageNamed:(NSString *)name;

// Performs image size checks
+ (UIImage *)mapTextureNamed:(NSString *)name;
+ (UIImage *)mapIconNamed:(nonnull NSString *)name;
+ (UIImage *)mapIconNamed:(nonnull NSString *)name forSize:(CGSize)size;
+ (UIImage *)mapIconNamed:(nonnull NSString *)name forSize:(CGSize)size withColor:(nullable UIColor *)color;


// Icon font support
+ (NSString *)iconFontName;
+ (NSString *)iconStringForPlacemarkType:(NSString *)placemarkType;

+ (UIColor *)arubaColor;

NS_ASSUME_NONNULL_END
@end
