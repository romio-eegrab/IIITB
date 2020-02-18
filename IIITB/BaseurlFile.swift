//  BaseurlFile.swift
//  Accenture Tech
//  Created by Generic Generic on 23/05/19.
//  Copyright © 2019 Generic Generic. All rights reserved.

import Foundation
import Meridian


// MARK : API
let baseURL = "https://letsfado.com/ihub/API/"
//let baseURL = "https://letsfado.com/ehub/API/"
let registerAPI = "register.php"
let loginAPI = "login.php"
let loginForKeyVisitorAPI = "login_keyvistor.php"
let getEventAPI = "getEvents.php"
let updateProfileAPI = "update_profile.php"
let updateResponseAPI =  "update_response.php"
let getAllEventAPI = "getAllEvents.php"
let getAvailableServiceAPI = "getAllservices.php"
let getAllBothStallAPI = "getbooths.php"
let updateEntryAPI = "update_entry.php"
let updateServiceResponseAPI = "update_service_response.php"
let updateExitFromStallAPI = "update_exit.php"
let updateAlertAPI = "update_alert.php"
let getBoothDetailsAPI = "getbooth_details.php"
let getEventDetailsAPI = "getEvents_details.php"
let getServiceDetailsAPI = "getbooth_service.php"
let getAllEventInvitesAPI = "getAllInvites.php"
let getQuestionAnswareAPI = "get_query.php"
let sendFeedbackAPI = "give_feedback.php"
let logoutAPI = "logout.php"

let appKeyEEgrab = "5488513526792192"
let mapKeyEEgrab = "5943317411659776"
let applicationTokenEEgrab = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0IjoxNTczNzk3OTk2LCJ2YWx1ZSI6ImFkNzdiZTdkMzU2Mzk1ZDY3ZWU4YmUyYzIyYTgyN2Y2ZWQxYWYyZjIifQ.DPzzyMHv1oAFVJiLdd8lsdGjj8w_1Ds-mTTHSVGX22I"


let indoorMapKey = MREditorKey(forMap: mapKeyEEgrab, app: appKeyEEgrab)
let searchingAPI = "https://edit.meridianapps.com/api/locations/" + appKeyEEgrab + "/search?q="
let locationAPI = "https://edit.meridianapps.com/api/locations/" + appKeyEEgrab

let buttonBorderColor1 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
let buttonBorderColor2 = UIColor(red: 219/255, green: 252/255, blue: 251/255, alpha: 1.0)
let tabViewColor = UIColor(red: 1, green: 197/255, blue: 0, alpha: 1.0)
let placeholderColor = UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)
let shadowColor_textFieldViewColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16)
let shadowColor_loginViewBorderColor = UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1.0)
let loginHeaderViewColor = UIColor(red: 26/255, green: 99/255, blue: 167/255, alpha: 1.0)
