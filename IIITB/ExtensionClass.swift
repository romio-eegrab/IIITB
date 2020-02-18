//
//  UIViewController+Support.swift
//  Denwa Sensei


import Foundation
import UIKit

extension UIViewController {
    
    //MARK: for Email validation
   func isValidEmail(emailStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    
    }
    
    func setNav()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default);
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    func setAttributeTitle(titleName : String) -> NSMutableAttributedString {
        
        let eventName = titleName
        var result = eventName.split(separator: " ")
        let firstStr = result[0]
        result.remove(at: 0)
        let endStr = result.joined(separator: " ")
        
      
        if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
            
            let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : UIColor.black]
            
            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : buttonBorderColor1]
            
            let attributedString1 = NSMutableAttributedString(string:String(firstStr), attributes:attrs1)
            
            let attributedString2 = NSMutableAttributedString(string:endStr, attributes:attrs2)
            let attributedString3 = NSMutableAttributedString(string:" ", attributes:attrs2)
            
            attributedString1.append(attributedString3)
            attributedString1.append(attributedString2)
            return attributedString1
        }
        else {
            let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
            
            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : buttonBorderColor1]
            
            let attributedString1 = NSMutableAttributedString(string:String(firstStr), attributes:attrs1)
            
            let attributedString2 = NSMutableAttributedString(string:endStr, attributes:attrs2)
            let attributedString3 = NSMutableAttributedString(string:" ", attributes:attrs2)
            
            attributedString1.append(attributedString3)
            attributedString1.append(attributedString2)
            return attributedString1
        }
       
        
    }
    func setDateFromStringDate(strDate : String) -> String {
        let dateFormatterGet = DateFormatter()
        let dateFormatterPrint = DateFormatter()
        var bookingDate = String()
        var bDate = Date()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm a"
        bDate = dateFormatterGet.date(from: strDate)!
        bookingDate = dateFormatterPrint.string(from: bDate )
        return bookingDate
    }
    
    func returnDateFromStringDate(strDate : String) -> Date {
        let dateFormatterGet = DateFormatter()
        var bookingDate = Date()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        bookingDate = dateFormatterGet.date(from: strDate)!
        return bookingDate
    }
    
    //MARK: Check a key is present in UserDefaults
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
   
    func stlFileToSave() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss-SSSS"
        let todaysDate = dateFormatter.string(from: date)
        return "STLFile-\(todaysDate).stl"
        
    }
    func textFileNameToSave() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss-SSSS"
        let todaysDate = dateFormatter.string(from: date)
        return "TextFile-\(todaysDate).txt"
        
    }

    //Resize marker icon
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func fourDigitNumber(fName: String, lName: String, countryCode: String) -> String {
        let initialName = "\(fName.prefix(1) )\((lName.prefix(1)))"

        var result = ""
        repeat {
            // Create a string with a random number 0...9999
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while result.count < 4
        result = initialName + result + countryCode
        return result
    }
    
    func imageNameForServer() -> String {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss-SSSS"
        let todaysDate = dateFormatter.string(from: date)
//        let strUserId = String(describing: ((UserDefaults.standard.value(forKey: "userDetails") as AnyObject).value(forKey: "userId"))!)
        return "uid-\(todaysDate).jpg"
    }

}

//MARK: View Extension
extension UIView{
    func setCirculer()  {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    func setCornerMolded(radiousVlaue : CGFloat)  {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radiousVlaue
        self.clipsToBounds = true
    }
    func setBorder(color : CGColor,borderWidth : CGFloat)  {
        self.layer.masksToBounds = false
        self.layer.borderColor = color
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    func setShadow(color : CGColor) {
        layer.shadowColor = color
        layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
       // layer.shadowRadius = 2.0
        layer.shadowOpacity = 2.0
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 3.5) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}

//MARK: Set Orientation
struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
//        if let delegate = UIApplication.shared.delegate as? AppDelegate {
//            delegate.orientationLock = orientation
//        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}

//MARK: Set Hex color
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

//MARK: Make circle of image
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setShadowView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.3
        layer.cornerRadius = 10.0
        layer.masksToBounds = true

    }
 
}

extension UIImage {
    // MARK: - UIImage+Resize
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}

extension UIButton {
    
    public func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shakeEffect() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

}

