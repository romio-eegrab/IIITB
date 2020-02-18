//  ActivityHelper.swift
//  Accenture Tech
//  Created by Generic Generic on 23/05/19.
//  Copyright © 2019 Generic Generic. All rights reserved.

import Foundation
import UIKit
//import MBProgressHUD

extension UIButton{
    
    class func backButtonTarget(_ target: Any, action: Selector) -> UIBarButtonItem {
        
        let backButton = UIButton(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(20), height: CGFloat(20)))
        backButton.setTitle("Cancel",for: .normal)
        backButton.setBackgroundImage(UIImage(named: "back.png"), for: .normal)
        let barBackButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        return barBackButtonItem
    }
    
    
}

extension UIViewController{
    
    
    
    func backButtonSelector() -> Void {
        
        
        
        self.navigationItem.leftBarButtonItem = UIButton.backButtonTarget(self, action: #selector(popCurrentViewController))
    }
    
    /*
     if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad )
     {
    let tlbl = UILabel()
     
     tlbl.text = " Manuals "
     tlbl.font = UIFont(name:"Exo-Bold",size:24)
     tlbl.sizeToFit()
     tlbl.textColor = UIColor.yellow
     navigationItem.titleView = tlbl
     
    }
     
     else
     
     {
     let tlbl = UILabel()
     
     tlbl.text = " Manuals "
     tlbl.font = UIFont(name:"Exo-Bold",size:22)
     tlbl.sizeToFit()
     tlbl.textColor = UIColor.yellow
     navigationItem.titleView = tlbl
     }
 */
    /*
     SourceSansPro-SemiboldIt
     SourceSansPro-BoldIt
     SourceSansPro-Regular
     SourceSansPro-Bold
     SourceSansPro-Semibold
 */
    
    func changeTitleName(title:String) -> Void
    {
        if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad )
        {
           let tlbl = UILabel()
            
            tlbl.text = title
            tlbl.font = UIFont(name:"SourceSansPro-Bold",size:30)
            tlbl.sizeToFit()
            tlbl.textColor = UIColor.gray
            self.tabBarController?.navigationItem.titleView = tlbl
            
        }
        else
        {
            let tlbl = UILabel()
            tlbl.text = title
            tlbl.font = UIFont(name:" SourceSansPro-Bold",size:22)
            tlbl.sizeToFit()
            tlbl.textColor = UIColor.darkGray
            self.tabBarController?.navigationItem.titleView = tlbl
        }
    }
    func changeTitlePosition(title:String) -> Void {
        
        if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
            
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 120.0, height: 50.0))
            customView.backgroundColor = UIColor.clear
            
            let button = UIButton.init(type: .custom)
            button.setBackgroundImage(UIImage(named: "back.png"), for: .normal)
            button.frame = CGRect(x: 0.0, y: 5.0, width: 40.0, height: 30.0)
            button.addTarget(self, action: #selector(menuOpen), for: .touchUpInside)
            customView.addSubview(button)
            
            let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 5)
            //  let label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: 120.0, height: 44.0))
            
            let label = UILabel(frame: CGRect(x: 60, y: 0.0, width: 350.0, height: 40.0))
            label.text = title
            label.textColor = UIColor.darkGray
            // label.textAlignment = NSTextAlignment.right
            label.textAlignment = NSTextAlignment.left
            label.backgroundColor = UIColor.clear
            label.font = UIFont(name: label.font.fontName, size: 30)
            customView.addSubview(label)
            
            let leftButton = UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = leftButton
        }
        else {
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 95.0, height: 44.0))
            customView.backgroundColor = UIColor.clear
            
            let button = UIButton.init(type: .custom)
            button.setBackgroundImage(UIImage(named: "back.png"), for: .normal)
            button.frame = CGRect(x: 0.0, y: 15.0, width: 20.0, height: 20.0)
            button.addTarget(self, action: #selector(menuOpen), for: .touchUpInside)
            customView.addSubview(button)
            
            let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 5)
            //  let label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: 120.0, height: 44.0))
            
            let label = UILabel(frame: CGRect(x: 35, y: 0.0, width: 190.0, height: 44.0))
            label.text = title
            label.textColor = UIColor.darkGray
            // label.textAlignment = NSTextAlignment.right
            label.textAlignment = NSTextAlignment.left
            label.backgroundColor = UIColor.clear
            label.font = UIFont(name: label.font.fontName, size: 20)
            customView.addSubview(label)
            
            let leftButton = UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = leftButton
            
        }
    }
    
    @objc func  menuOpen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func popCurrentViewController() -> Void {
        
        
        _ = self.navigationController?.popViewController(animated: true)
        
        NotificationCenter.default.post(name: Notification.Name("EnableMenu"), object: nil)
        
    }
    
    func changeView(_ view:UIView) -> Void {
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "c4c2c2").cgColor
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "f3f3f3")
        view.layer.cornerRadius = 5
    }
    
//    func attributedString(from string: String, nonBoldRange: NSRange?) -> NSAttributedString {
//
//        let fontSize = UIFont.systemFontSize
//        let attrs = [
//            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize),
//            NSAttributedStringKey.foregroundColorNSAttributedStringKey.foregroundColor: UIColor.black
//        ]
//        let nonBoldAttribute = [
//            NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize),
//            ]
//        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
//        if let range = nonBoldRange {
//            attrStr.setAttributes(nonBoldAttribute, range: range)
//        }
//        return attrStr
//    }
//
    func callHUD() {
        
        perform(#selector(self.dismiss1), with: nil, afterDelay: 0.5)
        
        //SVProgressHUD.showError(withStatus: "Error")
    }
    
    @objc func dismiss1() -> Void {
        
        // SVProgressHUD.dismiss()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlertMessage(alertTitle: String, alertMsg : String)
    {
        let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showAlert(title: String, message: String, noOfButton: NSNumber) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if noOfButton == 2 {
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                
                print("OK")
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
                
                print("CANCEL")
                
            }))
        }
        else{
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                
                print("OK")
                
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testStr)
        
    }
    
}

extension UIView{
    
    var newLayer:CALayer{
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.hexStringToUIColor(hex: "c4c2c2").cgColor
        self.layer.cornerRadius = 5
        
        return self.layer
    }
    
    var bgColor: UIView{
        
        self.bgColor.backgroundColor = UIColor.hexStringToUIColor(hex: "c4c2c2")
        return self.bgColor
    }
    
    
}


extension UIColor{
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
//        if ((cString.characters.count) != 6) {
//            return UIColor.gray
//        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


