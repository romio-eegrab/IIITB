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
        case crashTheApp = "Crash"
    }
    
    private let tableLayout: [(sectionTitle: sectionHeaders, rowTitles: [actionTitles])] = [
        (.actions, [
            .newUser,
            .createInvite,
            .acceptInvite,
            .viewMap,
            .viewProfile,
            .deleteProfile,
            .crashTheApp
            ]),
        (.friends, []),
        (.invites, [])
    ]
    
   
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
    }
    @objc func stopSharingButtonAction(notification : Notification) {
        
         print(" Stop Sharing Location")
        stopSharing()
    }
    
    @IBAction func createInvite(_ sender: Any) {
        
        MRInvite.createInvite(with: session) { invite, error in
            if error != nil {
                print("Something went wrong: \(error?.localizedDescription ?? "")")
            } else {
                if let shareURL = invite?.shareURL {
                    print("Invitation URL: \(shareURL)")
                }
            }
        }
 }
    
    @IBAction func retriveInvite(_ sender: Any) {
        
        MRInvite.getAllInvites(with: session) { invites, error in
            if error != nil {
                print("Something went wrong: \(error?.localizedDescription ?? "")")
            } else {
                print(String(format: "Got %lu invitations", UInt(invites?.count ?? 0)))
                if invites?.count != 0 {
                    print(invites?[0].shareURL )
                    print(invites?[0].friendKey.identifier)
                }
               
                
            }
        }
    }
    
    @IBAction func findAllFriend(_ sender: Any) {
        
        MRFriend.getAllFriends(with: session) { friends, error in
            if error != nil {
                print("Something went wrong: \(error?.localizedDescription ?? "")")
            } else {
                print(String(format: "Got %lu friends", UInt(friends?.count ?? 0)))
               // print("name ",friends[0].name)
            }
        }
    }
    
    @IBAction func getUserProfile(_ sender: Any) {
        
        MRFriend.getWith(session.key, session: session) { friend, error in
            if error != nil {
                print("Something went wrong: \(error?.localizedDescription ?? "")")
            } else {
                if let firstName = friend?.name {
                    print("Got data for \(firstName)")
                    print("sharing",friend?.sharing )
                }
               
//                friend?.updateName("Pritam", with: self.session, completion: {
//
//                    friend,error in
//                    if error != nil {
//                        print("failed to update profile: \(error)")
//                    }
//                    else {
//                        print("profile updated successfully")
//                        print("friend",friend?.name)
//                    }
//                })
                
            }
        }
    }
    
    @IBAction func acceptInvitation(_ sender: Any) {
        
        let alert = UIAlertController(title: "Accept Invite", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Invite Key"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
            if let alertText = alert?.textFields?[0].text, alertText.count > 0 {

                MRInvite.accept(with: MREditorKey(identifier: alertText), session: self!.session, completion: { [weak self] friendResult, error in
                    if friendResult != nil {

                        print("name",friendResult?.name)

                    } else if let thisError = error {
                        print("Accept Invite error: " + thisError.localizedDescription)
                    }
                })
               
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert, weak self] (_) in } ))
            
         present(alert, animated: true, completion: nil)
    }
    
//                MRInvite.accept(withURL: inviteURL, session: session) { friend, error in
//                    if error != nil {
//                        print("Something went wrong: \(error?.localizedDescription ?? "")")
//                    } else {
//                        if let firstName = friend?.firstName {
//                            print("Now sharing locations with \(firstName)")
//                        }
//                    }
//                }
                
                
                
//        MRInvite.accept(with: inviteURL!, session: self!.session, completion: { friend, error in
//                                    if error != nil {
//                                        print("Something went wrong: \(error?.localizedDescription ?? "")")
//                                    } else {
//                                        if let firstName = friend?.name {
//                                            print("Now sharing locations with \(firstName)")
//                                        }
//                                    }
//                                })
//                            }
//                    }))
      
    
    
    
}
extension FindFriendsController : UITableViewDataSource,UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//         return manager.friends.count
//    }
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
            cell.borderView.setBorder(color: UIColor.yellow.cgColor, borderWidth: 2)
            //  cell.nameTitle.text = manager.friends[indexPath.row].name
            if indexPath.row < manager.friends.count {
                cell.nameTitle?.text = manager.friends[indexPath.row].name
                cell.profileImg.sd_setImage(with: manager.friends[indexPath.row].imageURL, placeholderImage: UIImage(named: "persons icon"))
            }
         //   print("distance : ", manager.friends[indexPath.row].travelDistance ?? 44 )
     //    print("imageUrl : " , manager.friends[indexPath.row].imageURL)
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
                            self?.manager.reloadData()
                        }
                    })
                }
            case .acceptInvite:
                let alert = UIAlertController(title: "Accept Invite", message: nil, preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Invite Key"
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
                    if let alertText = alert?.textFields?[0].text, alertText.count > 0 {
                        if let thisSession = self?.manager.session {
                            MRInvite.accept(with: MREditorKey(identifier: alertText), session: thisSession, completion: { [weak self] friendResult, error in
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
                let profileController = MSProfileTableViewController()
                profileController.manager = manager
                navigationController?.pushViewController(profileController, animated: true)
            case .deleteProfile:
                manager.deleteAccount()
            case .crashTheApp:
               Crashlytics.sharedInstance().crash()
            }
            
        case .friends:
            if indexPath.row < manager.friends.count {
                let profileController = MSProfileTableViewController()
                profileController.manager = manager
                profileController.friend = manager.friends[indexPath.row]
                profileController.edgesForExtendedLayout = []
                navigationController?.pushViewController(profileController, animated: true)
            }
        case .invites:
            if indexPath.row < manager.invites.count {
                let inviteController = MSInviteTableViewController()
                inviteController.manager = manager
                inviteController.inviteKey = manager.invites[indexPath.row].key
                navigationController?.pushViewController(inviteController, animated: true)
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
            return 70
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
