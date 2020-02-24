//
//  FindFriendsController.swift
//  IIITB
//
//  Created by Generic Generic on 11/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit
import Meridian
import SDWebImage
import Fabric
import  Crashlytics


class FindFriendsController: UIViewController,MSFriendManagerObserver {
    func friendManagerDidUpdate(manager: MSFriendManager) {
        
    }
    
    func friendManagerDidFailWith(error: Error) {
        
    }
    

    
    @IBOutlet weak var friendsTblview: UITableView!
    var sharedLocationView = SharedLocationView()
    var session = MRSharingSession()
    var inviteKey: MREditorKey?
    var manager: MSFriendManager {
        get {
            return MSFriendManager.manager1 // overridden by subclass
        }
        set {} // read only
    }
    
    private enum sectionHeaders: String {
        case actions = "Actions"
        case friends = "Friends"
        case invites = "Invites"
    }
    
    private enum actionTitles: String {
        case newUser = "New User"
        case createInvite = "Create Invite"
        case acceptInvite = "Accept Invite"
        case viewMap = "View Map"
        case viewProfile = "View Profile"
        case deleteProfile = "Delete Profile"
       // case crashTheApp = "Crash"
        case sendInvitation = "Send Invitation"
    }
    
    private let tableLayout: [(sectionTitle: sectionHeaders, rowTitles: [actionTitles])] = [
        (.actions, [
            .newUser,
            .createInvite,
            .acceptInvite,
            .viewMap,
            .viewProfile,
            .deleteProfile,
            .sendInvitation
            ]),
        (.friends, []),
        (.invites, [])
    ]
    
   // .crashTheApp,
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sharedLocationView = SharedLocationView.instanceFromNib() as! SharedLocationView
        sharedLocationView.frame = CGRect(x:0, y: 130, width:self.view.frame.size.width, height:(70 ))
        self.view.addSubview(sharedLocationView)
        
        friendsTblview.register(UINib(nibName: "FindPersonsCell", bundle: nil), forCellReuseIdentifier: "FindPersonsCell")
        friendsTblview.dataSource = self
        friendsTblview.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sharedButtonAction(notification:)), name: Notification.Name("SharedButtonAction"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.stopSharingButtonAction(notification:)), name: Notification.Name("StopSharingButtonAction"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableData(notification:)), name: Notification.Name("ReloadTableData"), object: nil)
        
 
        manager.add(observer: self)
        manager.reloadData()
        MSFriendManager.setActiveManager(manager: manager)
        
        
    }
    @objc func reloadTableData(notification : Notification) {
        
   //     print("ReloadTableData")
        self.friendsTblview.reloadData()
    }
    @objc func sharedButtonAction(notification : Notification) {
        
      
      //  startSharing()
        
        print("shard locaton")
        /*
        let editorKey = MREditorKey(forMap: mapKeyEEgrab, app: appKeyEEgrab)
        let  password = UUID().uuidString
        MRSharingSession.createAccount(withPassword: password, name: "PRITAM", appKey: editorKey) { session, error in
            if error != nil {
                print("Something went wrong: \(error?.localizedDescription ?? "")")
            } else {
                // Now there's a sharing session.
                if let identifier = session?.key.identifier {
                    print("Got session: \(identifier)")
                }
                // Keeps a reference to the session. Needed for most subsequent requests.
                self.session = session!
                // Makes self the delegate to get callbacks with fresh data.
                self.session.delegate = self
            }
        }
 */
        let count = manager.invites.count
        self.inviteKey = manager.invites[count - 1].key
        if let url = getInvite()?.shareURL {
            let activityController = UIActivityViewController.init(activityItems: [url], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
        else {
            self.showAlert(title: "Alert", message: "You don't have any invitation link to share", noOfButton: 1)
        }
    }
    @objc func stopSharingButtonAction(notification : Notification) {
        
         print(" Stop Sharing Location")
        stopSharing()
    }
    
    private func getInvite() -> MRInvite? {
        
        let invites = manager.invites
        for invite in invites where invite.key == inviteKey {
            return invite
        }
        return nil
    }
    
}
extension FindFriendsController : UITableViewDataSource,UITableViewDelegate {
    

     func numberOfSections(in tableView: UITableView) -> Int {
        return tableLayout.count
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < tableLayout.count {
            return tableLayout[section].sectionTitle.rawValue
        }
        return nil
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < tableLayout.count {
            switch tableLayout[section].sectionTitle {
            case .actions:
                return tableLayout[section].rowTitles.count
            case .friends:
              //  print("friendsCount",manager.friends.count)
                return manager.friends.count
            case .invites:
//                 print("invitesCount",manager.invites.count)
                return manager.invites.count
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        if indexPath.section == 1 {
       let    cell = tableView.dequeueReusableCell(withIdentifier: "FindPersonsCell", for: indexPath) as! FindPersonsCell
            cell.borderView.setCirculer()
            cell.profileImg.setCirculer()
            cell.borderView.setBorder(color: buttonBorderColor3.cgColor, borderWidth: 3)
            
            //  cell.nameTitle.text = manager.friends[indexPath.row].name
            if indexPath.row < manager.friends.count {
                cell.nameTitle?.text = manager.friends[indexPath.row].name
                cell.profileImg.sd_setImage(with: manager.friends[indexPath.row].imageURL, placeholderImage: UIImage(named: "persons icon"))
            }
         //   print("distance : ", manager.friends[indexPath.row].travelDistance ?? 44 )
     //    print("imageUrl : " , manager.friends[indexPath.row].imageURL)
            print("distance : ",manager.friends[indexPath.row].travelTime)
            print("distance 2 : ",manager.friends[indexPath.row].travelDistance)
            print("distance 3 : ",manager.friends[indexPath.row].location?.point.x)
            cell.distanceTitle.text = String(Int( manager.friends[indexPath.row].travelDistance ?? 0)) + " meter"
            cell.selectionStyle = .none
             return cell
        }
        else {
            let cell = UITableViewCell.init(style: .value1, reuseIdentifier: nil)
            if indexPath.section >= tableLayout.count {
                return cell // Error
            }
            switch tableLayout[indexPath.section].sectionTitle {
            case .actions:
                if indexPath.row < tableLayout[indexPath.section].rowTitles.count {
                    cell.textLabel?.text = tableLayout[indexPath.section].rowTitles[indexPath.row].rawValue
                    if indexPath.row == 0 {
                        if let profileName = manager.profile?.name {
                            //   setEnabled(true, cell: cell)
                            cell.detailTextLabel?.text = String(format: "\"%@\"", profileName)
                        } else {
                            // setEnabled(true, cell: cell)
                            cell.detailTextLabel?.text = nil
                        }
                    } else {
                        //setEnabled(manager.session != nil, cell: cell)
                    }
                }
            case .friends:
                if indexPath.row < manager.friends.count {
                    cell.textLabel?.text = manager.friends[indexPath.row].name
                }
            case .invites:
                if indexPath.row < manager.invites.count {
                    cell.textLabel?.text = manager.invites[indexPath.row].key.identifier
                }
            }
            return cell
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section >= tableLayout.count {
            return
        }
        switch tableLayout[indexPath.section].sectionTitle {
        case .actions:
            if indexPath.row >= tableLayout[indexPath.section].rowTitles.count {
                break
            }
            switch tableLayout[indexPath.section].rowTitles[indexPath.row] {
            case .newUser:
                let alert = UIAlertController(title: "Create User", message: nil, preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Name"
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self]  (_) in
                    if let alertText = alert?.textFields?[0].text, alertText.count > 0 {
                        self?.manager.newAccountWith(password: NSUUID().uuidString, name: alertText)
                    }
                }))
                 alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil ))
                present(alert, animated: true, completion: nil)
            case .createInvite:
                if let thisSession = manager.session {
                    MRInvite.createInvite(with: thisSession, completion: { [weak self] _, error in
                        if let thisError = error {
                            self?.handleFriendError(error: thisError)
                        } else {
                            print("invitation link : ",thisSession.key.identifier)
                            
                            UserDefaults.standard.set(thisSession.key.identifier, forKey: "InvitationKey")
                            self?.manager.reloadData()
                        }
                    })
                }
            case .acceptInvite:
                let alert = UIAlertController(title: "Accept Invite", message: nil, preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Please enter Invite Key / Invite Link"
                   
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
                    if let alertText = alert?.textFields?[0].text, alertText.count > 0 {
                        if let thisSession = self?.manager.session {
                            
                            let getInputLink = alert?.textFields?[0].text
                            let staticLink = "https://edit.meridianapps.com/sharing/invites/"
                            var keyIdetifier = ""
                            if getInputLink?.contains(staticLink) ?? false {
                                
                                keyIdetifier = getInputLink?.replacingOccurrences(of: staticLink, with: "") ?? "romio"
                            }
                            else {
                                keyIdetifier = alert?.textFields?[0].text ?? "romio"
                            }
                           print(keyIdetifier)
                            //alertText
                            MRInvite.accept(with: MREditorKey(identifier: keyIdetifier), session: thisSession, completion: { [weak self] friendResult, error in
                                if friendResult != nil {
                                    self?.manager.reloadData()
                                } else if let thisError = error {
                                    print("Accept Invite error: " + thisError.localizedDescription)
                                }
                            })
                        }
                    }
                }))
                 alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil ))
                
                present(alert, animated: true, completion: nil)
            case .viewMap:
                if let thisSession = manager.session {
                    let mapController = MSFriendMapViewController()
                    mapController.friends = manager.friends
                    mapController.session = thisSession
                    navigationController?.pushViewController(mapController, animated: true)
                }
            case .viewProfile:
//                let profileController = MSProfileTableViewController()
//                profileController.manager = manager
//                navigationController?.pushViewController(profileController, animated: true)

                let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                profileVC.manager = manager
                navigationController?.pushViewController(profileVC, animated: true)
            case .deleteProfile:
                manager.deleteAccount()
//            case .crashTheApp:
//                Crashlytics.sharedInstance().crash()
            case .sendInvitation:
                print("Send Invitation")
                
                let count = manager.invites.count
                self.inviteKey = manager.invites[count - 1].key
               if let url = getInvite()?.shareURL {
                    let activityController = UIActivityViewController.init(activityItems: [url], applicationActivities: nil)
                    present(activityController, animated: true, completion: nil)
                }
                else {
                    self.showAlert(title: "Alert", message: "You don't have any invitation link to share", noOfButton: 1)
                }
            }
            
        case .friends:
            if indexPath.row < manager.friends.count {
//                let profileController = MSProfileTableViewController()
//                profileController.manager = manager
//                profileController.friend = manager.friends[indexPath.row]
//                profileController.edgesForExtendedLayout = []
//                navigationController?.pushViewController(profileController, animated: true)
                
                let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                profileVC.manager = manager
                profileVC.friend = manager.friends[indexPath.row]
                profileVC.edgesForExtendedLayout = []
                navigationController?.pushViewController(profileVC, animated: true)
                
            }
        case .invites:
            if indexPath.row < manager.invites.count {
//                let inviteController = MSInviteTableViewController()
//                inviteController.manager = manager
//                inviteController.inviteKey = manager.invites[indexPath.row].key
//                navigationController?.pushViewController(inviteController, animated: true)

                let inviteVC = self.storyboard?.instantiateViewController(withIdentifier: "InviteController") as! InviteController
                inviteVC.manager = manager
                inviteVC.inviteKey = manager.invites[indexPath.row].key
                self.navigationController?.pushViewController(inviteVC, animated: true )

            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section < tableLayout.count {
            let sectionTitle = tableLayout[indexPath.section].sectionTitle
            return sectionTitle == .friends || sectionTitle == .invites
        }
        return false
    }

    private func handleFriendError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func setEnabled(_ enabled: Bool, cell: UITableViewCell) {
        cell.textLabel?.isEnabled = enabled
        cell.isUserInteractionEnabled = enabled
        cell.selectionStyle = enabled ? .default : .none
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let thisSession = manager.session, indexPath.section < tableLayout.count else {
            return
        }
        if editingStyle == .delete {
            switch tableLayout[indexPath.section].sectionTitle {
            case .friends:
                if indexPath.row < manager.friends.count, let key = manager.friends[indexPath.row].key {
                    MRFriend.remove(with: key, session: thisSession, completion: { [weak self] error in
                        if let thisError = error {
                            print("remove friend error: " + thisError.localizedDescription)
                        } else {
                            self?.manager.reloadData()
                        }
                    })
                    tableView.reloadData()
                }
            case .invites:
                if indexPath.row < manager.invites.count {
                    manager.invites[indexPath.row].delete(with: thisSession, completion: { [weak self] error in
                        if let thisError = error {
                            print("delete invite error: " + thisError.localizedDescription)
                        } else {
                            self?.manager.reloadData()
                        }
                    })
                    tableView.reloadData()
                }
            default:
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 100
        }
        else {
           return 30
        }
        
    }
}
extension FindFriendsController : MRSharingSessionDelegate {
    

    func startSharing() {
        
        print("Start Location")
        session.startListeningForUpdates()
        session.startPostingLocationUpdates()
    }
    
    func stopSharing() {
        print("Stop Location")
        session.stopListeningForUpdates()
        session.stopPostingLocationUpdates()
    }
    
    // Adopts the MRSharingSessionDelegate protocol to receive callbacks.
    private func sharingSession(_ session: MRSharingSession?, friendsDidUpdate friends: [AnyHashable]?) {
        // The friends array has the latest location sharing data for each friend.
        print("Share  Session")
        print(friends as Any)
    }
    
    func sharingSession(_ session: MRSharingSession, didFailWithError error: Error) {
        print("Sharing session error: \(error.localizedDescription )")
    }
}
