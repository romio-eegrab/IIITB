//
//  TabController.swift
//  IIITB
//
//  Created by Generic Generic on 06/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    
    @IBOutlet var tabView: UIView!
    @IBOutlet weak var myFriendView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var professorView: UIView!
    @IBOutlet weak var myFriendButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var professorButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabTitlelbl: UILabel!
    
    var menuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        self.view.backgroundColor = loginHeaderViewColor
        self.navigationController?.isNavigationBarHidden = false
        self.selectedIndex = 1
        self.tabBar.isHidden = true
        navigationController?.navigationBar.barTintColor = loginHeaderViewColor
        
        if (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX) || ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR) {
           self.tabView.frame = CGRect(x: 0, y: (self.view.frame.height - 85), width: self.view.frame.width, height: 85)
            
        }
        else {
            self.tabView.frame = CGRect(x: 0, y: (self.view.frame.height - 70), width: self.view.frame.width, height: 70)
        }
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 130)
        myFriendButton.backgroundColor = tabViewColor
        mapButton.backgroundColor = UIColor.white
        professorButton.backgroundColor = tabViewColor
        
        self.view.addSubview(self.tabView)
        self.view.addSubview(headerView)
        
        menuView = MenuView.instanceFromNib() as! MenuView
        menuView.frame = CGRect(x:( -self.view.frame.size.width), y: 0, width:self.view.frame.size.width, height:(self.view.frame.size.height ))
        self.menuView.isHidden = true
        self.view.addSubview(menuView)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.backButtonAction(notification:)), name: Notification.Name("BackButtonAction"), object: nil)
        
    }
    @objc func backButtonAction(notification : Notification) {
        
        slideViewHideAnimation()
    }
    
    @IBAction func tabAction(_ sender: Any) {
        
       self.selectedIndex = (sender as AnyObject).tag
        switch (sender as AnyObject).tag {
        case 0:
            
            myFriendButton.backgroundColor = UIColor.white
            mapButton.backgroundColor = tabViewColor
            professorButton.backgroundColor = tabViewColor
            tabTitlelbl.text = "My Friends"
            break
        case 1:
            myFriendButton.backgroundColor = tabViewColor
            mapButton.backgroundColor = UIColor.white
            professorButton.backgroundColor = tabViewColor
            tabTitlelbl.text = "Welcome To IIITB"
            break
        case 2:
            myFriendButton.backgroundColor = tabViewColor
            mapButton.backgroundColor = tabViewColor
            professorButton.backgroundColor = .white
            tabTitlelbl.text = "My Professors"
            break
        default:
            myFriendButton.backgroundColor = UIColor.white
            mapButton.backgroundColor = tabViewColor
            professorButton.backgroundColor = tabViewColor
            break
        }
        
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        
        menuTabButtonAction()
       // showAlert(title: "Alert", message: "This part is under development", noOfButton: 1)
    }
    @objc func menuTabButtonAction() {
        
        if menuView.frame.origin.x < 0 {
            
            UIView.animate(withDuration: 0.4, animations: {() -> Void in
                 self.menuView.frame = CGRect(x: CGFloat(0), y: (0), width: CGFloat(self.view.frame.width), height: CGFloat(self.view.frame.size.height ))
                self.updateFocusIfNeeded()
                self.updateViewConstraints()
                self.menuView.isHidden = false
              })
        }
        else {
            slideViewHideAnimation()
        }
        
    }
    
    
    
    func slideViewHideAnimation() {
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
             self.menuView.frame = CGRect(x: CGFloat( -self.view.frame.width), y: CGFloat(0), width: CGFloat(self.view.frame.width), height: CGFloat(self.view.frame.size.height))
            
        }, completion: {(_ finished: Bool) -> Void in
            
            self.menuView.isHidden = true
        })
       
    }
}
