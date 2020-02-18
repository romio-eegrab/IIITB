//
//  HomeController.swift
//  IIITB
//
//  Created by Generic Generic on 06/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit
import Meridian

class HomeController: UIViewController,MRLocationManagerDelegate {

    @IBOutlet weak var containerView: UIView!
    var mapViewController: MRMapViewController?
    var mapViewContainer: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = loginHeaderViewColor
        containerView.backgroundColor = .white // very important
        containerView.layer.cornerRadius = 2.0
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 1, height:1)
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        mapViewContainer = UIView(frame: CGRect(x: 0, y:20, width: view.bounds.size.width - 24, height:containerView.frame.height - 40))
       
        updateViewConstraints()
        if let mapViewContainer = mapViewContainer {
            self.containerView.addSubview(mapViewContainer)
        }
        
        let mapKey = indoorMapKey
        mapViewController = MRMapViewController(editorKey: mapKey, isChildViewController: true)
        mapViewController?.mapView.showsTags = true
        mapViewController?.mapView.showsUserLocation = true
        mapViewController?.mapView.showsWatermark = true
        mapViewController?.mapView.backgroundColor = .white
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let mapViewController = mapViewController, let mapViewContainer = mapViewContainer else { return }
        addChild(mapViewController)
        mapViewController.navigationController?.navigationBar.isHidden = true
        mapViewController.view.frame = mapViewContainer.bounds
        mapViewContainer.addSubview(mapViewController.view)
        mapViewController.didMove(toParent: self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let mapViewController = mapViewController else { return }
        mapViewController.willMove(toParent: nil)
        mapViewController.view.removeFromSuperview()
        mapViewController.removeFromParent()
      
        
    }

    @IBAction func supportButtonAction(_ sender: Any) {
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
       self.navigationController?.popToRootViewController(animated: true)
        // navigationController?.popViewController(animated: true)
    }
    
}
