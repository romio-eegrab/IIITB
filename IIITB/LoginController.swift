//
//  LoginController.swift
//  IIITB
//
//  Created by Generic Generic on 06/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var borderlbl: UILabel!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Login Controller")
        setPlaceholderColer(textField: userNameTxt, str: "Enter your username")
        setPlaceholderColer(textField: passwordTxt, str: "Enter your password")
        
        usernameView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        passwordView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        borderlbl.setShadow(color:shadowColor_loginViewBorderColor.cgColor)
        goButton.setCornerMolded(radiousVlaue: 10.0)
        goButton.setBorder(color: buttonBorderColor2.cgColor, borderWidth: 3.0)
       
        goButton.layer.masksToBounds = false
        goButton.layer.shadowOpacity = 1.6
        goButton.layer.shadowRadius = 4
        goButton.layer.shadowOffset = CGSize(width: 1, height:1)
        goButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor

        
        
        backButton.setCornerMolded(radiousVlaue: 10.0)
        backButton.setBorder(color: buttonBorderColor1.cgColor, borderWidth: 3.0)
        
        userNameTxt.delegate = self
        passwordTxt.delegate = self
        animShow()
        
    }
   
   
    func animShow(){
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn],
                       animations: {
                        self.scrollview.center.y -= self.scrollview.bounds.height
                        self.scrollview.layoutIfNeeded()
        }, completion: nil)
        self.view.isHidden = false
    }

    
    
    @IBAction func goButtonAction(_ sender: Any) {
        
//       let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "MSFriendTableViewController") as! MSFriendTableViewController
//        self.navigationController?.pushViewController(tabVC, animated: true)
        
        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabController") as! TabController
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
   
}

extension LoginController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameTxt {
            passwordTxt.becomeFirstResponder()
        }
        else {
            passwordTxt.resignFirstResponder()
        }
        return true
    }
    
}
