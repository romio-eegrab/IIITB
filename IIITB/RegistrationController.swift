//
//  RegistrationController.swift
//  IIITB
//
//  Created by Generic Generic on 06/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registrationView: UIView!
    @IBOutlet weak var borderlbl: UILabel!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var streamView: UIView!
    @IBOutlet weak var streamTxt: UITextField!
    @IBOutlet weak var streamButton: UIButton!
    @IBOutlet weak var streamTblview: UITableView!
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var yearTxt: UITextField!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var yearTblview: UITableView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var yearVSCons: NSLayoutConstraint!
    @IBOutlet weak var signupButtonVSCons: NSLayoutConstraint!
    
    
    let yearArr = ["First Year","Second Year","Third Year","Fourth Year"]
    let courseArr = ["Mechanical","Electrical","Civil","Eletronics","CSE","IT"]
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setPlaceholderColer(textField: userNameTxt, str: "Enter your name")
        setPlaceholderColer(textField: passwordTxt, str: "Enter your password")
        setPlaceholderColer(textField: emailTxt, str: "Enter your email")
        setPlaceholderColer(textField: phoneTxt, str: "Enter your phone")
        setPlaceholderColer(textField: streamTxt, str: "— Select —")
        setPlaceholderColer(textField: yearTxt, str: "— Select —")
        
        userNameView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        passwordView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        emailView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        phoneView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        streamView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        yearView.setShadow(color: shadowColor_textFieldViewColor.cgColor)
        borderlbl.setShadow(color:shadowColor_loginViewBorderColor.cgColor)
        signupButton.setCornerMolded(radiousVlaue: 10.0)
        signupButton.setBorder(color: buttonBorderColor2.cgColor, borderWidth: 3.0)
        backButton.setCornerMolded(radiousVlaue: 10.0)
        backButton.setBorder(color: buttonBorderColor1.cgColor, borderWidth: 3.0)
        

        streamTblview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
         yearTblview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        self.yearTblview.dataSource = self
        self.yearTblview.delegate = self
        self.streamTblview.dataSource = self
        self.streamTblview.delegate = self
        
        yearTblview.isHidden = true
        streamTblview.isHidden = true
        yearVSCons.constant = 16.0
        signupButtonVSCons.constant = 30.0
        
        
        let bar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        bar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let reset = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        reset.titlePositionAdjustment(for: .default)
        bar.items = [flexSpace,reset]
        bar.sizeToFit()
        phoneTxt.inputAccessoryView = bar
        
       animShow()
        
    }
    
    func animShow(){
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn],
                       animations: {
                        self.scrollView.center.y -= self.scrollView.bounds.height
                        self.scrollView.layoutIfNeeded()
        }, completion: nil)
        self.view.isHidden = false
    }
    
    @objc func doneTapped(){
        phoneTxt.resignFirstResponder()
    }
    @IBAction func streamButtonAction(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.4, animations: {
            self.streamTblview.isHidden = false
            self.yearTblview.isHidden = true
            self.yearVSCons.constant = 178.0
            self.signupButtonVSCons.constant = 16.0
           
        }, completion: {
            (value: Bool) in
            
        })
    }
    
    
    @IBAction func yearButtonAction(_ sender: Any) {
        
         UIView.animate(withDuration: 2.0, delay: 1.5, options: [.transitionCurlUp], animations: {
            self.streamTblview.isHidden = true
            self.yearTblview.isHidden = false
            self.yearVSCons.constant = 16.0
            self.signupButtonVSCons.constant = 185.0
            
        })
        UIView.animate(withDuration: 1.0, animations: {
            self.yearButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        })
        
    }
    
    
    @IBAction func signupButtonAction(_ sender: Any) {
        
        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabController") as! TabController
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
extension RegistrationController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameTxt {
            emailTxt.becomeFirstResponder()
        }
        else if textField == emailTxt {
            phoneTxt.becomeFirstResponder()
        }
        else if textField == passwordTxt {
            passwordTxt.resignFirstResponder()
        }
        
        return true
    }
    
}
extension RegistrationController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yearTblview {
             return yearArr.count
        }
        else {
             return courseArr.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let cell =
           let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        if tableView == yearTblview {
             cell.showlbl.text = yearArr[indexPath.row]
        }
        else {
             cell.showlbl.text = courseArr[indexPath.row]
        }
       
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == yearTblview {
            yearTxt.text = yearArr[indexPath.row]
        }
        else {
            streamTxt.text = courseArr[indexPath.row]
        }
        yearTblview.isHidden = true
        streamTblview.isHidden = true
        yearVSCons.constant = 16.0
        signupButtonVSCons.constant = 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 30
    }
    
    
}
