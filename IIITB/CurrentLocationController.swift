//
//  ViewController.swift
//  Accenture Indoor Navigation
//
//  Created by Generic Generic on 08/07/19.
//  Copyright © 2019 Generic Generic. All rights reserved.
//

import UIKit
import Meridian
import Alamofire
import Speech
import MBProgressHUD



class CurrentLocationController: UIViewController,MRLocationManagerDelegate,SFSpeechRecognizerDelegate {
    
    
    @IBOutlet weak var voiceIcon: UIImageView!
    
    // MARK: List of outlets
    @IBOutlet weak var mapViewNew: UIView!
    @IBOutlet var switchEventView: UIView!
    @IBOutlet weak var placemarksTableview: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet var upDownView: UIView!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var resourceCollView: UICollectionView!
    @IBOutlet weak var eventTblview: UITableView!
    @IBOutlet var buttonView: UIView!
    @IBOutlet weak var overviewBtn: UIButton!
    @IBOutlet weak var endnowBtn: UIButton!
    @IBOutlet weak var searchTblView: UITableView!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var resourceHeaderView: UIView!
    @IBOutlet weak var searchHeaderview: UIView!
    @IBOutlet weak var resourceCollviewVSCons: NSLayoutConstraint!
    @IBOutlet weak var txtView: UIView!
    @IBOutlet weak var voiceSearchButton: UIButton!
    @IBOutlet weak var alertlbl: UILabel!
    
    
    
    // MARK: List of variable
    var gestureRecognizer = UIPanGestureRecognizer(),searchGestureRecognizer = UIPanGestureRecognizer()
  
    var parameters: [String: String] = [:]
    var header : HTTPHeaders = [:]
    var jsonFetch = JsonFetchClass()
  
    var mapViewContainer: UIView?
    var mapViewController: MRMapViewController?
    let titlelbl = UILabel()
    let mapButton = UIButton()
    private var results = [MRPlacemarkResult]()
    private var request: MRPlacemarkRequest?
    var isVoiceButtonClick = false,timer = Timer(),selectedEvent = 0
    var eventDetails = NSArray(),searchPortalsArr = NSArray(),isSerarchClick = false,searchPlacemarksArr = NSArray(),allPlaceMarkerArr = NSArray(),placemarkerName = "",closestBooth = "",isNearBooth = NSMutableArray(),isCloestBoothFound = false,shorestDistance = 0.0,isHelpToolShownComplete = false
    private var directions: MRDirections?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var speechResult = SFSpeechRecognitionResult()
    
    //   var eventData : JSON? = nil
   
    var eventData = NSArray(),serviceName = String(),eventLocationPosition = NSMutableArray()
    // MARK: View Load Method
    private lazy var mrLocationManager: MRLocationManager = {
        let locationManager = MRLocationManager(app: MREditorKey(identifier: appKeyEEgrab))
        locationManager.delegate = self
        return locationManager
    }()
    var mrlocation = MRLocation()
    var mrlocation2 = MRLocation()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // locationManager = MRLocationManager(app: indoorMapKey)
        //  locationManager.delegate = self
      //  placemarksTableview.isHidden = true
        containerView.setBorder(color: UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor, borderWidth: 1)
        containerView.backgroundColor = .white // very important
        containerView.layer.cornerRadius = 2.0
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 1, height:1)
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        
        
          if UIDevice.current.userInterfaceIdiom == .pad {
            
            if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
                
                mapViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width - 60, height: view.bounds.height - 300))
            }
        }
          else {
            
            if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX ) || (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR) {
                mapViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width - 32, height: view.bounds.height - 280))
            }
            else {
                mapViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width - 32, height: view.bounds.height - 240))
            }
        }
        
       
        updateViewConstraints()
        if let mapViewContainer = mapViewContainer {
            self.mapViewNew.addSubview(mapViewContainer)
        }
        
        let mapKey = indoorMapKey
        mapViewController = MRMapViewController(editorKey: mapKey, isChildViewController: true)
        mapViewController?.mapView.showsTags = true
        mapViewController?.mapView.showsUserLocation = true
        mapViewController?.mapView.showsWatermark = true
        mapViewController?.mapView.backgroundColor = .white
       
      //  setUpwordMovingView()
      //  loadPortals(searchingTxt : "Portal")
       
      
       
    }
  
   
    func sendPlaceMarkerDetails(data: NSDictionary) {
        print(data)
    }
    
    @objc func navigate(notification: Notification) {
     
        let id = (notification.object as! String)
        print(id)
        let array = id.components(separatedBy: ",") as NSArray
        loadPlacemarks(identifier: array[0] as! String)
        placemarkerName = array[1] as! String
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
                // Code you want to be delayed
                self.orientationChanged()
                self.setUpwordMovingView()
                self.view.updateConstraintsIfNeeded()
                self.view.updateConstraints()
            }
            
        }
        else {
            guard let mapViewController = mapViewController, let mapViewContainer = mapViewContainer else { return }
            addChild(mapViewController)
            mapViewController.view.frame = mapViewContainer.bounds
            
            titlelbl.frame = CGRect(x: view.center.x / 2, y: 40, width: 200, height: 20)
            titlelbl.text = "Powred by EEGRAB"
            titlelbl.textColor = .lightGray
            titlelbl.textAlignment = .center
            titlelbl.font = UIFont(name:"Roboto-Medium",size:13)
            //  mapViewController.view.addSubview(titlelbl)
            if (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX ) || (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR) {
                mapButton.frame = CGRect(x: (self.view.frame.width - 80), y: (self.view.frame.height - 340), width: 45, height: 45)
            }
            else {
                mapButton.frame = CGRect(x: (self.view.frame.width - 80), y: (self.view.frame.height - 300), width: 45, height: 45)
            }
            
            mapButton.backgroundColor = .white
            mapButton.setCornerMolded(radiousVlaue: 6.0)
            mapButton.setShadow(color: UIColor.darkGray.cgColor)
            mapButton.setBackgroundImage(UIImage(named: "search icon"), for: .normal)
            mapButton.addTarget(self, action: #selector(searchAction(_:)), for: .touchUpInside)
            mapViewController.view.addSubview(mapButton)
            
            let subscription = MRDMapTagSubscription(identifier: mapViewController.mapView.mapKey.identifier)
            mapViewController.mapView.tagSubscriptions = [subscription]
            mapViewController.navigationController?.navigationBar.isHidden = false
            mapViewContainer.addSubview(mapViewController.view)
            mapViewController.didMove(toParent: self)
            
            // self.setUpwordMovingView()
        }
   
       
    }
   
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let mapViewController = mapViewController else { return }
        mapViewController.willMove(toParent: nil)
        titlelbl.removeFromSuperview()
        mapButton.removeFromSuperview()
        mapViewController.view.removeFromSuperview()
        mapViewController.removeFromParent()
        mrLocationManager.stopUpdatingLocation()
      
    }

 
   
    @IBAction func updateAction(_ sender: Any) {
        
        let url = baseURL + updateResponseAPI
        print(url)
        parameters = [
            "userid" : UserDefaults.standard.value(forKey: "userID") as! String,
        ]
        
        print(parameters)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        header = ["Content-Type":"application/x-www-form-urlencoded;charset=UTF-8",
                  "Accept": "application/json",
                  "Token" : ((UserDefaults.standard.value(forKey: "profileData") as! NSDictionary).object(forKey: "secretkey") as! String)]
        jsonFetch.fetchData(parameters, methodType: "POST", url: url, JSONName: "GetEvent",header : header)
    }
    
    // MARK: API Calls
    private func loadPortals(searchingTxt : String) {
        
        let url = searchingAPI + searchingTxt
        print(url)
        jsonFetch.fetchData(parameters, methodType: "GET", url: url, JSONName: "Portals",header : [:])
    }
    
    private func loadSearchingPlacemarks(searchingTxt : String) {
        let url = searchingAPI + searchingTxt
        print(url)
        jsonFetch.fetchData(parameters, methodType: "GET", url: url, JSONName: "Searching_Placemarks",header : [:])
    }
    func loadAllPlacemarks(searchingTxt : String) {
        let url = locationAPI + searchingTxt + "page_size=1000"
        print(url)
        jsonFetch.fetchData(parameters, methodType: "GET", url: url, JSONName: "LoadAllPlacemarks",header : [:])
    }
    func eventsData(){
        // let url = locationAPI + "/events"
        let url = baseURL + getEventAPI
        print(url)
        parameters = [
            "userid" : UserDefaults.standard.value(forKey: "userID") as! String,
        ]
        
        print(parameters)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        header = ["Content-Type":"application/x-www-form-urlencoded;charset=UTF-8",
                  "Accept": "application/json",
                  "Token" : ((UserDefaults.standard.value(forKey: "profileData") as! NSDictionary).object(forKey: "secretkey") as! String)]
        print(header)
        jsonFetch.fetchData(parameters, methodType: "POST", url: url, JSONName: "GetEvent",header : header)
    }
    
    // MARK: Button Action
    @IBAction func overviewAction(_ sender: Any) {
        self.mapViewController?.mapView.scrollToOverview()
    }
    @IBAction func endRouteAction(_ sender: Any) {
        placemarkerName = ""
        timer.invalidate()
        upDownView.isHidden = false
        self.buttonView.isHidden = true
        self.mapViewController?.mapView.setRoute(nil, animated: true)
    }
    
    @objc func searchAction(_ sender: Any) {
        
        print("search")
        isSerarchClick = true
        upDownView.isHidden = false
        viewUp(status: "Search")
        //loadPlacemarks()
    }
    
    private func loadPlacemarks(identifier : String) {
        
        results.removeAll()
        //  request = MRPlacemarkRequest()
        request = MRPlacemarkRequest(app: indoorMapKey, placemarkIdentifier: identifier, mapKey: indoorMapKey)
        request?.app = MREditorKey(identifier: appKeyEEgrab)
        request?.start(completionHandler: { [weak self] response, error in
           
            self?.placemarksLoadedWithResposne(response: response, error: error)
        })
    }
    
    private func placemarksLoadedWithResposne(response: MRPlacemarkResponse?, error: Error?) {
        if let requestError = error {
            print("Error loading placemarks: " + requestError.localizedDescription)
            upDownView.isHidden = false
            self.buttonView.isHidden = true
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlert(title: "Error", message: "Loading placemark not found", noOfButton: 1)
            return
        }
        if let responseResults = response?.results {
            results += responseResults
           // loadDirection(name: placemarkerName)
            
        }
    }
    
    @IBAction func informationButtonAction(_ sender: Any) {
        print("information")
//        popupView = PopupView.instanceFromNib() as! PopupView
//        popupView.frame = CGRect(x:0, y: 20, width:self.view.frame.size.width, height:(self.view.frame.size.height ))
//        popupView.okBtn.setBorder(color: buttonBorderColor.cgColor, borderWidth: 2.0)
//        popupView.mainView.setShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor)
//        popupView.eventNamelbl.text = "About Us"
//        popupView.eventDescriptionTxt.isHidden = false
//        popupView.eventDescriptionTxt.text = "Accenture plc, stylised as accent͐ure, is an Irish-domiciled multinational professional services company that provides services in strategy, consulting, digital, technology and operations."
//        popupView.okBtn.isHidden = false
//        popupView.txtfieldView.isHidden = true
//        popupView.submiteButton.isHidden = true
//        popupView.okBtn.setCornerMolded(radiousVlaue: 15.0)
//        popupView.mainView.setCornerMolded(radiousVlaue: 10.0)
//        self.view.addSubview(popupView)
        
    }
    
    @IBAction func voiceSearchAction(_ sender: Any) {
        
       
    }
    
  
    @objc private func layoutMarkers(selectedTitle : String) {
        //   print(selectedTitle)
        
        var isPlaceMarkersFound = false
        var foundedPlaceMark = MRPlacemark()
        for case let placemark as MRPlacemark in mapViewController!.mapView.placemarks {
            //            print("title",placemark.title)
            //            print("type",placemark.type)
            //            print("typeName",placemark.typeName)
            if placemark.type == "elevator" {
                if let title = placemark.title, title.contains(selectedTitle) {
                    isPlaceMarkersFound = true
                    foundedPlaceMark = placemark
                    break
                }
            }
            else {
                if let title = placemark.type, title == selectedTitle {
                    isPlaceMarkersFound = true
                    foundedPlaceMark = placemark
                    break
                }
            }
        }
        
        if isPlaceMarkersFound == true {
            mapViewController!.mapView.deselectAnnotation(animated: true)
            let width: CGFloat = 15 * mapViewController!.mapView.map.unitsPerMeter
            let visibleRect = CGRect(x: foundedPlaceMark.point.x - width/2, y: foundedPlaceMark.point.y - width/2, width: width + 5.0, height: width + 5.0 )
            mapViewController!.mapView.setVisibleMapRect(visibleRect, rotationAngle: CGFloat(Double.pi/4), animated: true, completion: nil)
            mapViewController!.mapView.selectAnnotation(foundedPlaceMark, animated: true)
        }
        else {
            // showAlert(title: "Alert", message: "Could not find this portal", noOfButton: 1)
            // Create the alert controller
            let alertController = UIAlertController(title: "Alert", message: "This Point of Interest marker is not in this floor,would you like to find other place", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                
                self.viewUp(status: "Search")
            }
            let cancelAction = UIAlertAction(title: "No,Thanks", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                self.mapViewController!.mapView.deselectAnnotation(animated: true)
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func helpButtonAction(_ sender: Any) {
        
//        print("help")
//        popupView = PopupView.instanceFromNib() as! PopupView
//        popupView.frame = CGRect(x:0, y: 20, width:self.view.frame.size.width, height:(self.view.frame.size.height ))
//        popupView.okBtn.setBorder(color: buttonBorderColor.cgColor, borderWidth: 2.0)
//        popupView.mainView.setShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor)
//        popupView.eventNamelbl.text = "HELP"
//        popupView.eventDescriptionTxt.isHidden = false
//        popupView.eventDescriptionTxt.text = "Please use the search bar to find and navigate to a POI"
//        popupView.okBtn.isHidden = false
//        popupView.txtfieldView.isHidden = true
//        popupView.submiteButton.isHidden = true
//        popupView.okBtn.setCornerMolded(radiousVlaue: 15.0)
//        popupView.mainView.setCornerMolded(radiousVlaue: 10.0)
//        self.view.addSubview(popupView)
    }
    @IBAction func switchEventAction(_ sender: Any) {
        
       
    }
    
    @IBAction func crossButtonAction(_ sender: Any) {
        switchEventView.removeFromSuperview()
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        
        if (searchTxt.text!.trimmingCharacters(in: .whitespaces).isEmpty ) {
            isSerarchClick = false
            resourceHeaderView.isHidden = false
            searchHeaderview.isHidden = true
            viewDown(status: "Search")
        }
        else {
            searchTxt.text = ""
        }
    }
    
    // MARK: Set Frame of View && Handel Pan Gesture
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            
            UIView.animate(withDuration: 2.0, delay: 1.8, options: .curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
            }, completion:
                {_ in
                    
                    UIView.animate(withDuration: 0.4, animations: {
                        
                        if translation.y < 0
                        {
                            // view up
                            if self.searchPortalsArr.count > 0 {
                                self.viewUp(status: "swipe")
                            }
                            else {
                                self.showAlertMessage(alertTitle: "Alert", alertMsg: "No portals to show")
                            }
                        }
                        else
                        {
                            // view down
                            self.viewDown(status: "swipe")
                        }
                    }) { (success) in
                        
                    }
            })
        }
    }
 
    func setUpwordMovingView() {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
                upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 125), width: CGFloat(self.view.frame.size.width), height: CGFloat(230))
                
            }
            
        }
        else {
            if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX ) {
                
                upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 100), width: CGFloat(self.view.frame.size.width), height: CGFloat(300))
            }
            else if (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR)  {
                
                upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 100), width: CGFloat(self.view.frame.size.width), height: CGFloat(300))
            }
            else if (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphone6plus)  || (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphone5) {
                
                upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 80), width: CGFloat(self.view.frame.size.width), height: CGFloat(230))
            }
            else if (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphone7)   {
                
                upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 85), width: CGFloat(self.view.frame.size.width), height: CGFloat(230))
            }
            else
            {
                upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 80), width: CGFloat(self.view.frame.size.width), height: CGFloat(230))
            }
        }
        
        updateViewConstraints()
        upDownView.setShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor)
        gestureRecognizer.view!.frame =  upDownView.frame
        gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        self.upDownView.addGestureRecognizer(gestureRecognizer)
        upDownView.alpha = 0.5
        self.view.addSubview(upDownView)
       
    }
    
    func viewUp(status : String) {
        
        
        if status == "Search" {
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                resourceCollviewVSCons.constant = 18.0
                upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 500), width: CGFloat(self.view.frame.size.width), height: CGFloat(500))
            }
            else {
                if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX ) || (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR) {
                    
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(180), width: CGFloat(self.view.frame.size.width), height: CGFloat(self.view.frame.height - 180))
                }
                    
                else {
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(160), width: CGFloat(self.view.frame.size.width), height: CGFloat(self.view.frame.height - 160))
                }
            }
            
            
           
            if searchPlacemarksArr.count == 0 {
                searchTblView.isHidden = true
            }
            else {
                searchTblView.isHidden = false
            }
            resourceHeaderView.isHidden = true
            searchHeaderview.isHidden = false
        }
        else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
                    resourceCollviewVSCons.constant = 18.0
                    upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 350), width: CGFloat(self.view.frame.size.width), height: CGFloat(350))
                }
            }
            else {
                 resourceCollviewVSCons.constant = 6.0
                if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX ) || (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR) {
                    
                    
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 240), width: CGFloat(self.view.frame.size.width), height: CGFloat(300))
                }
                else {
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 230), width: CGFloat(self.view.frame.size.width), height: CGFloat(230))
                }
            }
            
          
            searchTblView.isHidden = true
            placemarksTableview.isHidden = true
            resourceHeaderView.isHidden = false
            searchHeaderview.isHidden = true
            
        }
        upDownView.alpha = 1.0
    }
    func viewDown(status : String) {
        
        if status == "Search" {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
                    upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 125), width: CGFloat(self.view.frame.size.width), height: CGFloat(400))
                }
            }
            else {
                if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX ) || (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR) {
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 100), width: CGFloat(self.view.frame.size.width), height: CGFloat(300))
                }
                else {
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 80), width: CGFloat(self.view.frame.size.width), height: CGFloat(300))
                }
            }
        }
        else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
                    upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 125), width: CGFloat(self.view.frame.size.width), height: CGFloat(400))
                }
            }
            else {
                if ( UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneX ) || (UIDevice.Display.typeIsLike == UIDevice.DisplayType.iphoneXR) {
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 100), width: CGFloat(self.view.frame.size.width), height: CGFloat(300))
                }
                else {
                    self.upDownView.frame = CGRect(x: CGFloat(0), y: CGFloat(self.view.frame.height - 80), width: CGFloat(self.view.frame.size.width), height: CGFloat(300))
                }
            }
           
        }
        
        if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
            resourceCollviewVSCons.constant = 18.0
        }
        else {
            resourceCollviewVSCons.constant = 6.0
        }
        
        searchTblView.isHidden = true
        placemarksTableview.isHidden = true
        searchHeaderview.isHidden = true
        resourceHeaderView.isHidden = false
        upDownView.alpha = 0.8
    }
   
    
    func orientationChanged() {
        var text = ""
        switch UIDevice.current.orientation{
        case .portrait:
            text="Portrait"
        case .portraitUpsideDown:
            text="PortraitUpsideDown"
        case .landscapeLeft:
            text="LandscapeLeft"
        case .landscapeRight:
            text="LandscapeRight"
        default:
            text="Another"
        }
        
        print(text)
        
        
        
        
        guard let oldMapViewController = mapViewController else { return }
        oldMapViewController.willMove(toParent: nil)
        
        mapButton.removeFromSuperview()
        oldMapViewController.view.removeFromSuperview()
        oldMapViewController.removeFromParent()
     
        if UIDevice.Display.typeIsLike == UIDevice.DisplayType.ipad {
           
           
        guard let mapViewController = mapViewController, let newMapViewContainer = mapViewContainer else { return }
         //    mapViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width - 60, height: view.bounds.height - 240))
          //  mapViewContainer?.removeConstraints()
            
            addChild(mapViewController)
            
          //  mapViewController.view.frame = mapViewContainer!.bounds
            
            if text == "Portrait" {
                newMapViewContainer.frame = CGRect(x: 0, y: 0, width: 708, height: 724)
                mapViewController.view.frame = CGRect(x: 0, y: 0, width: 708, height: 724)
                 mapButton.frame = CGRect(x: (588), y: (600), width: 55, height: 55)
            }
            else {
                newMapViewContainer.frame = CGRect(x: 0, y: 0, width: 964, height: 468)
                 mapViewController.view.frame = CGRect(x: 0, y: 0, width: 964, height: 468)
                 mapButton.frame = CGRect(x: (844), y: (348), width: 55, height: 55)
            }
          //  mapViewController.mapView.frame = mapViewController.view.frame
            self.mapViewNew.addSubview(newMapViewContainer)
          

         //   mapButton.backgroundColor = .red
            mapButton.showsTouchWhenHighlighted = true
            mapButton.setCornerMolded(radiousVlaue: 6.0)
            mapButton.setShadow(color: UIColor.darkGray.cgColor)
            mapButton.setBackgroundImage(UIImage(named: "search icon"), for: .normal)
            mapButton.addTarget(self, action: #selector(searchAction(_:)), for: .touchUpInside)
           // mapViewController.mapView.backgroundColor = .yellow
            mapViewController.view.addSubview(mapButton)

            let subscription = MRDMapTagSubscription(identifier: mapViewController.mapView.mapKey.identifier)
            mapViewController.mapView.tagSubscriptions = [subscription]
            mapViewController.navigationController?.navigationBar.isHidden = false
            newMapViewContainer.addSubview(mapViewController.view)
            mapViewController.didMove(toParent: self)
            
            mapViewController.view.updateConstraintsIfNeeded()
            mapViewController.view.updateConstraints()
            
//            containerView.backgroundColor = .green
//            mapViewNew.backgroundColor = .orange
//            mapViewContainer?.backgroundColor = .blue
//            mapViewController.view.backgroundColor = .brown
           
         }
        
       
    }
   
}
extension CurrentLocationController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTxt.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
         voiceIcon.image = UIImage(named: "voice search off icon")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
         voiceIcon.image = UIImage(named: "voice search on icon")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if (searchTxt.text!.trimmingCharacters(in: .whitespaces).isEmpty ) {
            
            loadSearchingPlacemarks(searchingTxt: string )
        }
        else {
            loadSearchingPlacemarks(searchingTxt: searchTxt.text ?? "Ele")
            // searchTblView.reloadData()
        }
        return true
    }
}
//extension CurrentLocationController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
//extension CurrentLocationController : UITableViewDataSource,UITableViewDelegate

//extension CurrentLocationController : jsonDataDelegate
