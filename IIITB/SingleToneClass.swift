//  SingleToneClass.swift
//  Accenture Tech
//  Created by Generic Generic on 23/05/19.
//  Copyright © 2019 Generic Generic. All rights reserved.

import UIKit

class SingleToneClass {
    
    private init() {}
    
    static let shared = SingleToneClass()
    var selectedDate = String()
    var isNearBeacon = Bool()
    var notificationData = NSDictionary()
    var isAvailableServiceClick = Bool()
    var selectedEventData = NSArray()
    var selectedBoothData = NSDictionary()
    var cloestBooth = NSDictionary()
    var closestEventID = String()
    var selectedFinishEventID = String()
    var isFinishBoothSelected = Bool()
    var currentClass = String()
    var selectedServiceID = String()
    var selctedBoothID = String()
    var isEventInvitationSelected = String()
}
