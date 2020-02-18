//
//  MRDButton.h
//
//  Copyright © 2018 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>


/** Basic UIButton but with a built-in feedback when touched (shrink 3%, darken 20%)
 *   can be used directly, or as intermediate base class for other button classes
*/
@interface MRDButton : UIButton

- (void)addDefaultFeedback;
- (void)removeDefaultFeedback;

@end
