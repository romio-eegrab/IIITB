//
//  InviteController.swift
//  IIITB
//
//  Created by Generic Generic on 19/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class InviteController: UIViewController {

     var headerView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = HeaderView.instanceFromNib() as! HeaderView
        headerView.frame = CGRect(x:0, y: 0, width:self.view.frame.size.width, height: 70)
        self.view.addSubview(headerView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.backButtonAction(notification:)), name: Notification.Name("BackButtonAction"), object: nil)
    }
    
    @objc func backButtonAction(notification : Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
