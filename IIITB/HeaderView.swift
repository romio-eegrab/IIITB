//
//  HeaderView.swift
//  IIITB
//
//  Created by Generic Generic on 19/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var titlelbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    private func setupView() {
        // backgroundColor = .white
        
        
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
         NotificationCenter.default.post(name: Notification.Name("BackButtonAction"), object: nil)
    }
    
}
