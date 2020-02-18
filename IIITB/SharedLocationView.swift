//
//  SharedLocationView.swift
//  IIITB
//
//  Created by Generic Generic on 12/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class SharedLocationView: UIView {
    
    
    
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
        return UINib(nibName: "SharedLocationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
   
    @IBAction func sharedButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SharedButtonAction"), object: nil)
    }
    
    
    @IBAction func stopSharingButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("StopSharingButtonAction"), object: nil)
    }
    
}
