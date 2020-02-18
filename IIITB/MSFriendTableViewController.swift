//
//  MSFriendTableViewController.swift
//  MeridianSwiftSamples
//
//  Created by Stephen Kelly on 5/23/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

import UIKit
import Meridian

class MSFriendTableViewController: UITableViewController, MSFriendManagerObserver {
    // enums for table layout
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

    var manager: MSFriendManager {
        get {
            return MSFriendManager.manager1 // overridden by subclass
        }
        set {} // read only
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.add(observer: self)
        manager.reloadData()
        MSFriendManager.setActiveManager(manager: manager)
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - MSExampleViewController

    class func exampleTitle() -> String {
        return "Friend A"
    }

    class func exampleDetail() -> String {
        return "Example of how to show friends on a map, as well as manage user profiles and friend lists."
    }

    // MARK: - UITableViewController

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableLayout.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < tableLayout.count {
            return tableLayout[section].sectionTitle.rawValue
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < tableLayout.count {
            switch tableLayout[section].sectionTitle {
                case .actions:
                    print(" count : ",tableLayout[section].rowTitles.count)
                    return tableLayout[section].rowTitles.count
                case .friends:
                    return manager.friends.count
                case .invites:
                    return manager.invites.count
            }
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = UITableViewCell.init(style: .value1, reuseIdentifier: nil)
          let cell = tableView.dequeueReusableCell(withIdentifier: "FindPersonsCell", for: indexPath) as! FindPersonsCell
        if indexPath.section >= tableLayout.count {
            return cell // Error
        }
        switch tableLayout[indexPath.section].sectionTitle {
        case .actions:
            if indexPath.row < tableLayout[indexPath.section].rowTitles.count {
                cell.textLabel?.text = tableLayout[indexPath.section].rowTitles[indexPath.row].rawValue
                if indexPath.row == 0 {
                    if let profileName = manager.profile?.name {
                        setEnabled(false, cell: cell)
                        cell.detailTextLabel?.text = String(format: "\"%@\"", profileName)
                    } else {
                        setEnabled(true, cell: cell)
                        cell.detailTextLabel?.text = nil
                    }
                } else {
                    setEnabled(manager.session != nil, cell: cell)
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section < tableLayout.count {
            let sectionTitle = tableLayout[indexPath.section].sectionTitle
            return sectionTitle == .friends || sectionTitle == .invites
        }
        return false
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            case .crashTheApp: break
                
              
            }

        case .friends:
            if indexPath.row < manager.friends.count {
                let profileController = MSProfileTableViewController()
                profileController.manager = manager
                profileController.friend = manager.friends[indexPath.row]
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    // MARK: - MSFriendManagerObserver

    func friendManagerDidUpdate(manager: MSFriendManager) {
        tableView.reloadData()
    }

    func friendManagerDidFailWith(error: Error) {
        handleFriendError(error: error)
    }

    // MARK: - Utilities

    private func setEnabled(_ enabled: Bool, cell: UITableViewCell) {
        cell.textLabel?.isEnabled = enabled
        cell.isUserInteractionEnabled = enabled
        cell.selectionStyle = enabled ? .default : .none
    }

    private func handleFriendError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

class MSFriendTableViewController2: MSFriendTableViewController {
    override class func exampleTitle() -> String {
        return "Friend B"
    }

    override var manager: MSFriendManager {
        get {
            return MSFriendManager.manager2
        }
        set {} // read only
    }
}

class MSFriendTableViewController3: MSFriendTableViewController {
    override class func exampleTitle() -> String {
        return "Friend C"
    }

    override var manager: MSFriendManager {
        get {
            return MSFriendManager.manager3
        }
        set {} // read only
    }
}
