
        //  ScreenSize Extension.swift

        import Foundation
        import UIKit


        extension UIDevice{

            public enum DisplayType {
                
                case unknown
                case iphone4
                case iphone5
                case iphone6
                case iphone6plus
                case iphoneX
                case iphoneXR
                case ipad
                
                // iphone 6,7,8,6s size
                static let iphone7 = iphone6
                static let iphine8 = iphone6
                static let iphone6s = iphone6
                // iphone (6,7,8,6s) plus size
                static let iphone7plus = iphone6plus
                static let iphone8plus = iphone6plus
                static let iphone6splus = iphone6plus
                // iphone 5,5s,5c,SE size
                static let iphoneSE = iphone5
                static let iphone5s = iphone5
                static let iphone5c = iphone5
               // iphone X,XS,11 pro (X serise) size
                static let iphoneXS = iphoneX
                static let iphone11Pro = iphoneX
                 // iphone XR,11  size
                static let iphone11 = iphoneXR
                static let iphoneXSMax = iphoneXR
                static let iphoneMaxPro = iphoneXR
                
                
            }
            
            
            
            public final class Display {
                
                
                
                class var width:CGFloat { return UIScreen.main.bounds.size.width }
                
                class var height:CGFloat { return UIScreen.main.bounds.size.height }
                
                class var maxLength:CGFloat { return max(width, height) }
                
                class var minLength:CGFloat { return min(width, height) }
                
                class var zoomed:Bool { return UIScreen.main.nativeScale >= UIScreen.main.scale }
                
                class var retina:Bool { return UIScreen.main.scale >= 2.0 }
                
                class var phone:Bool { return UIDevice.current.userInterfaceIdiom == .phone }
                
                class var pad:Bool { return UIDevice.current.userInterfaceIdiom == .pad }
                
        //        class var carplay:Bool { return UIDevice.current.userInterfaceIdiom == .carPlay }
        //
        //        class var tv:Bool { return UIDevice.current.userInterfaceIdiom == .tv }
                
             // if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
                
                class var typeIsLike:DisplayType {
                    
        //            if phone && maxLength < 568 {
        //
        //                return .iphone4
        //
        //            }
                    
                 if phone && maxLength == 568 {
                    
                        return .iphone5
                    
                    }
                    
                    
                    else if phone && maxLength == 667 {
                    
                        return .iphone6
                    
                    }
                    
                    else if phone && maxLength == 736 {
                    
                        return .iphone6plus
                    
                    }
                 else  if phone && maxLength == 812 {
                    return .iphoneX
                    
                 }
                    else  if phone && maxLength == 896 {
                        return .iphoneXR
                    
                    }
                 else  if pad && maxLength == 1024 {
                    return .ipad
                    
                    }
               
                    return .unknown
                    
                }
                
         }
        }

