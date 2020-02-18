//
//  MSFriendMapViewController.swift
//  MeridianSwiftSamples
//
//  Created by Stephen Kelly on 5/23/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

import UIKit
import Meridian

class MSFriendMapViewController: MRMapViewController, MRSharingSessionDelegate {
    var friends = [MRFriend]()
    var button = UIButton()
    var session: MRSharingSession? {
        willSet (newValue) {
            newValue?.delegate = self
        }
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        mapView.mapKey = MREditorKey(forMap: mapKeyEEgrab, app: appKeyEEgrab)
        mapView.showsUserLocation = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        button.frame = CGRect(x: 8, y: 25, width: 50, height: 50)
        button.setImage(UIImage(named: "back icon"), for: .normal)
        button.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        self.view.addSubview(button)
        
        reloadAnnotations()
        
        
    }
    @objc func logoutUser(){
       // print("clicked")
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - MRMapViewDelegate

    override func mapViewDidFinishLoadingMap(_ mapView: MRMapView) {
        super.mapViewDidFinishLoadingMap(mapView)
        reloadAnnotations()
    }

    // MARK: - MRSharingSessionDelegate

    func sharingSession(_ session: MRSharingSession, didFailWithError error: Error) {
        // noop
    }

    func sharingSession(_ session: MRSharingSession, friendsDidUpdate friends: [MRFriend]) {
        self.friends = friends
        reloadAnnotations()
    }

    // MARK: - Internal

    private func reloadAnnotations() {
        var myFriendsOnMap = [MRFriend]()
        for friend in friends {
            guard let mapKey = friend.location?.mapKey else {
                continue
            }
            if mapKey == mapView.mapKey {
                myFriendsOnMap.append(friend)
            }
        }

        var toRemove = [MRAnnotation]()
        for case let annotation as MRFriend in mapView.annotations {
            toRemove.append(annotation)
        }

        mapView.removeAnnotations(toRemove)
        mapView.addAnnotations(myFriendsOnMap)
    }
}
