//  TextfieldPlaceholderColor.swift
//  Accenture Tech
//  Created by Generic Generic on 23/05/19.
//  Copyright © 2019 Generic Generic. All rights reserved.

import Foundation
import UIKit

extension UIViewController{
    
    func setPlaceholderColer(textField : UITextField,str : String)
    {
//        textField.attributedPlaceholder = NSAttributedString(string: str,
//                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)])
        
        
       // UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        textField.attributedPlaceholder = NSAttributedString(string:str,
                                                             attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
       // textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.font = UIFont(name: "Arial", size: 18)
    }
    
    
    
}
