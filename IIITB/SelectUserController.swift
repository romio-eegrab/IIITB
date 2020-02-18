//
//  SelectUserController.swift
//  IIITB
//
//  Created by Generic Generic on 06/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit


class SelectUserController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
 
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var professorButton: UIButton!
    @IBOutlet weak var newUserButton: UIButton!
    @IBOutlet weak var exitingUserButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    let simpleOver = SimplyOver()
   var userType =  ("student","exitingUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // navigationController?.delegate = self
        
        goButton.setCornerMolded(radiousVlaue: 10.0)
        goButton.setBorder(color: buttonBorderColor2.cgColor, borderWidth: 3.0)
        goButton.setShadow(color: shadowColor_textFieldViewColor.cgColor)
       
        userType.0 = "student"
        studentButton.setBorder(color:buttonBorderColor1.cgColor, borderWidth: 4.0)
        professorButton.setBorder(color: UIColor.clear.cgColor, borderWidth: 1.0)
        
         studentButton.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        newUserButton.setImage(UIImage(named: "selected icon"), for: .normal)
        exitingUserButton.setImage(UIImage(named: "unselected icon"), for: .normal)
        userType.1 = "newUser"
        
    }
    internal func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        simpleOver.popStyle = (operation == .pop)
        return simpleOver
    }

    @IBAction func studentButtonAction(_ sender: Any) {
        
       userType.0 = "student"
        studentButton.setBorder(color:buttonBorderColor1.cgColor, borderWidth: 5.0)
        professorButton.setBorder(color: UIColor.clear.cgColor, borderWidth: 1.0)
        studentButton.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        professorButton.setShadow(color: UIColor.clear.cgColor)
    }
    
    @IBAction func professorButtonAction(_ sender: Any) {
        
       userType.0 = "professor"
        professorButton.setBorder(color:buttonBorderColor1.cgColor, borderWidth: 5.0)
        studentButton.setBorder(color: UIColor.clear.cgColor, borderWidth: 1.0)
        studentButton.setShadow(color: UIColor.clear.cgColor)
        professorButton.setShadow(color: shadowColor_textFieldViewColor.cgColor)
    }
    
    @IBAction func userTypeButtonAction(_ sender: Any) {
        
        
        if ((sender as Any) as AnyObject).tag == 0 {
            
            newUserButton.setImage(UIImage(named: "selected icon"), for: .normal)
            exitingUserButton.setImage(UIImage(named: "unselected icon"), for: .normal)
            userType.1 = "newUser"
        }
        else {
            newUserButton.setImage(UIImage(named: "unselected icon"), for: .normal)
            exitingUserButton.setImage(UIImage(named: "selected icon"), for: .normal)
            userType.1 = "exitingUser"
        }
        
        
    }

    @IBAction func goButtonAction(_ sender: Any) {
//        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
//        Crashlytics.crashlytics()
//        fatalError()
        
        if userType.0 == "student" {
            if userType.1 == "newUser" {
                
                let registrationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! RegistrationController
                navigationController?.pushViewController(registrationVC, animated: true)
            }else {
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
               navigationController?.pushViewController(loginVC, animated: true)
              
            }
            
        }
        else {
            if userType.1 == "newUser" {
                
                let registrationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! RegistrationController
                navigationController?.pushViewController(registrationVC, animated: true)
            }else {
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
                navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
    
}
