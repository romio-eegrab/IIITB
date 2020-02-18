//
//  MRDTextView.h
//  MeridianiOSControls
//
//  Created by Daniel Miedema on 10/1/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRDTextView : UITextView
/// Placeholder text to show when the textview is empty
@property (nonatomic, nullable, copy) NSString *placeholder;
/// Attributed Placeholder text to show when the textview is empty
@property (nonatomic, nullable, copy) NSAttributedString *attributedPlaceholder;
@end
