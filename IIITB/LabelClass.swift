//
//  LabelClass.swift
//  Accenture Indoor Navigation
//
//  Created by Generic Generic on 25/09/19.
//  Copyright © 2019 Generic Generic. All rights reserved.
//

import Foundation
import UIKit

class LabelClass: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        
        self.textAlignment = .center
       // self.font = UIFont(name: "Arial", size: 17)
        self.font = UIFont(name: "Arial", size: 12)
        self.textColor = UIColor.red
        
    }
    
}
