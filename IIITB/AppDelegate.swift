//
//  AppDelegate.swift
//  IIITB
//
//  Created by Generic Generic on 06/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit
import Meridian
import Firebase
import CoreBluetooth
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate {

    var window: UIWindow?
    var centralManager: CBCentralManager?
    var peripheralHeartRateMonitor: CBPeripheral?
    let notificationCenter = UNUserNotificationCenter.current()

// IIITB
    // fcm token //d_TWOrVfTEFTIZOkMF4d-v:APA91bGPri-YiQRiwjJ9m9CFJ5pvZdQdd5PD5-HdW2W1MVajvZ4Z-amKqTn4LUkhytVi0veb0Ia-Yxlmkky6ksQIq2zhjtmVfWixFDky2QQwAK-dPGQLDX-NK98m-twfuJ29BKwEyafp6
    // de
    // IIITB clone

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = MRConfig()
        config.domainConfig.domainRegion = MRDomainRegion.default
        config.applicationToken = applicationTokenEEgrab
        config.rerouteDelay = 6.0
        Meridian.configure(config)
        
        
        let options = FirebaseOptions(googleAppID: "1:888867421679:ios:5c28fe8502a2eb821b8a1a", gcmSenderID: "888867421679")
        options.bundleID = "com.eegrab.IIITB"
        options.apiKey = "AIzaSyCv_nvo4Vc9mSjDESYI4ZBHScBejnQAL_c"
        options.projectID = "iiitb-d0e23"
        options.clientID = "888867421679-fqbaa3ifga3rmuo2gtmcb86c6n8m8cb6.apps.googleusercontent.com"
        
        FirebaseApp.configure(options: options)
        Messaging.messaging().delegate = self
      
        
        //  notificationCenter.delegate = self
        UIApplication.shared.setMinimumBackgroundFetchInterval(10)
        application.registerForRemoteNotifications()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate{
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        //  let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        let deviceTokenString = deviceToken.hexString
        // UserDefaults.standard.set(deviceTokenString, forKey: "deviceTokenString")
        Messaging.messaging().apnsToken = deviceToken
        //  print(Messaging.messaging().fcmToken)
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
    //    let alertTitle = "Device Token"
        
      //  let alert = UIAlertController(title: alertTitle, message: deviceTokenString, preferredStyle: .actionSheet)
//        DispatchQueue.main.async {
//            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//        }
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        //    print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "deviceTokenString")
        // let dataDict:[String: String] = ["token": fcmToken]
        //NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        
//        let alertTitle = "FCM TOKEN"
//
//        let alert = UIAlertController(title: alertTitle, message: fcmToken, preferredStyle: .actionSheet)
//        DispatchQueue.main.async {
//            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//        }
    }
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        //print(fcmToken)
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
        //print("remoteMessage",remoteMessage)
    }
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        //print("APNs registration failed: \(error)")
    }
    
    /*]]
     {
     description = "Notificatin Test2";
     "event_id" = 24;
     userid = 7;
     }
     */
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        //print("Push notification received: \(data)")
        
       // handleNotification(data: ((data as NSDictionary)))
    }
    
    func handleNotification(data : NSDictionary) {
        
        let aps = ((data as NSDictionary).object(forKey: "aps") as! NSDictionary)
        let details =  ((data as NSDictionary).object(forKey: "gcm.notification.details") as! String)
        //print(details)
        //print(aps)
        
        if ((aps.object(forKey: "alert") as! NSDictionary).object(forKey: "title") as! String) == "You have recieve an invitation" {
            
            let dict = convertToDictionary(text: details )
            //print(dict! as NSDictionary)
           
            
            let alertTitle = "You have received an invitation to " + ((dict! as NSDictionary).object(forKey: "name") as! String) + " event"
            
            let alert = UIAlertController(title: alertTitle, message: "Are you ?? ", preferredStyle: .actionSheet)
            
            
            
            alert.addAction(UIAlertAction(title: "INTERESTED", style: .default , handler:{ (UIAlertAction)in
                //print("Interested")
               
            }))
            
            alert.addAction(UIAlertAction(title: "MAYBE", style: .default , handler:{ (UIAlertAction)in
                //print("Maybe")
                
            }))
            
            alert.addAction(UIAlertAction(title: "NOT INTERESTED", style: .destructive , handler:{ (UIAlertAction)in
                
               
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                //print("Cancel")
                
            }))
            DispatchQueue.main.async {
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
            
            //        switch UIApplication.shared.applicationState{
            //        case .background,.inactive :
            //            let alertController = UIAlertController(title: "Alert", message: (((data as NSDictionary).object(forKey: "aps") as! NSDictionary).object(forKey: "alert") as! String), preferredStyle: .alert)
            //
            //            // Create the actions
            //            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            //                UIAlertAction in
            //
            //            }
            //            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            //                UIAlertAction in
            //
            //            }
            //
            //            // Add the actions
            //            alertController.addAction(okAction)
            //            alertController.addAction(cancelAction)
            //
            //            DispatchQueue.main.async {
            //                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            //            }
            //
            //            break
            //        case .active :
            //            // foreground
            //            print("active")
            //
            //
            //            break
            //        default:
            //            break
            //        }
            
            
        }
            
        else if ((aps.object(forKey: "alert") as! NSDictionary).object(forKey: "title") as! String) == "This is not a booth" {
            
            //print("Not in a booth")
            //print(aps)
        }
            
        else {
            //print(aps)
            SingleToneClass.shared.notificationData = aps
            let details =  ((data as NSDictionary).object(forKey: "gcm.notification.details") as! String)
            //            guard  let str = ((((data as NSDictionary).object(forKey: "aps") as! NSDictionary).object(forKey: "alert") as!NSDictionary).object(forKey: "body") ) else {
            //
            //                let alertController = UIAlertController(title: "Alert", message: "Could not retrive your booth details", preferredStyle: .alert)
            //
            //                // Create the actions
            //                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            //                    UIAlertAction in
            //
            //                }
            //                alertController.addAction(okAction)
            //                DispatchQueue.main.async {
            //                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            //                }
            //                return
            //            }
            
            let dict = convertToDictionary(text: details)
            //print(dict! as NSDictionary)
            
            if  ((((data as NSDictionary).object(forKey: "aps") as! NSDictionary).object(forKey: "alert") as!NSDictionary).object(forKey: "title") as! String) == "Thanks for comming"  {
                NotificationCenter.default.post(name: Notification.Name("BoothFound"), object: [:])
            }
            else {
                NotificationCenter.default.post(name: Notification.Name("BoothFound"), object: dict)
            }
            
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                //print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //
    //        print("notification taped")
    //    }
    
    
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
extension AppDelegate : CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
            
        case .unknown:
            print("Bluetooth status is UNKNOWN")
            
        case .resetting:
            print("Bluetooth status is RESETTING")
            
        case .unsupported:
            print("Bluetooth status is UNSUPPORTED")
            
        case .unauthorized:
            print("Bluetooth status is UNAUTHORIZED")
            
        case .poweredOff:
            print("Bluetooth status is POWERED OFF")
            
        case .poweredOn:
            //print("Bluetooth status is POWERED ON")
            // STEP 3.2: scan for peripherals that we're interested in
            // campaignManager.startMonitoring()
            startScan()
            
        @unknown default:
            return
        } // END switch
    }
    func startScan(){
        //print("blu on")
        if let central = centralManager {
            //print("scan start...")
            central.scanForPeripherals(withServices: nil, options: nil)
            
        }
        else {
            //print("could not find central manager....")
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        //print(" APP DELEGATE Discoverd")
        // print(peripheral.name!)
        decodePeripheralState(peripheralState: peripheral.state)
        peripheralHeartRateMonitor = peripheral
        centralManager?.stopScan()
        
        // STEP 6: connect to the discovered peripheral of interest
        centralManager?.connect(peripheralHeartRateMonitor!)
        
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        //print("Connected")
        // campaignManager.startMonitoring()
        
    }
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
        //print("could not connected",error!)
        //scheduleNotification(notificationType: "notificationType")
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        //print("Disconnected!")
        centralManager?.scanForPeripherals(withServices: nil)
        centralManager?.connect(peripheralHeartRateMonitor!)
        //  campaignManager.startMonitoring()
    } // END func centralManager(... didDisconnectPeripheral peripheral
    
    // MARK: - CBPeripheralDelegate methods
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        for service in peripheral.services! {
            //print(service)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        for characteristic in service.characteristics! {
            //print(characteristic)
            
            
            
        } // END for
        
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        //print(error)
    }
    
    
    func decodePeripheralState(peripheralState: CBPeripheralState) {
        
        switch peripheralState {
        case .disconnected:
            print("Peripheral state: disconnected")
        case .connected:
            print("Peripheral state: connected")
        case .connecting:
            print("Peripheral state: connecting")
        case .disconnecting:
            print("Peripheral state: disconnecting")
        @unknown default:
            return
        }
        
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    
    
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        let categoryIdentifire = "Delete Notification Type"
        
        content.title = notificationType
        content.body = "This is example how to create " + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = "LocalNotification"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "LocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                //print("Error \(error.localizedDescription)")
            }
        }
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: categoryIdentifire,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
}
