//
//  MSFriendManager.swift
//  MeridianSwiftSamples
//
//  Created by Stephen Kelly on 5/23/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//
import Meridian

protocol MSFriendManagerObserver: class {
    func friendManagerDidUpdate(manager: MSFriendManager)
    func friendManagerDidFailWith(error: Error)
}

class MSFriendManager {
    // 3 lazy-initialized "singletons"
    static let manager1 = MSFriendManager(identifier: "manager1")
    static let manager2 = MSFriendManager(identifier: "manager2")
    static let manager3 = MSFriendManager(identifier: "manager3")

    private init(identifier: String) {
        self.identifier = identifier
        if let key = friendKey, let keyPassword = password {
            
            print("keyPassword", keyPassword)
            print("key", friendKey)
            
            MRSharingSession.login(with: key, password: keyPassword, appKey: MREditorKey(forMap: mapKeyEEgrab, app: appKeyEEgrab), completion: { [weak self] loginSession, error in
                if let thisSession = loginSession {
                    self?.session = thisSession
                } else if let thisError = error {
                    print("Session login error: " + thisError.localizedDescription)
                }
            })
        }
    }

    private var observers = [MSFriendManagerObserver]()
    private var pendingInvites = [URL]()
    private var identifier = ""
    private var friendKey: MREditorKey? {
        get {
            if let key = UserDefaults.standard.string(forKey: identifier + " key") {
                return MREditorKey(identifier: key)
            }
            return nil
        }
        set (newValue) {
            UserDefaults.standard.set(newValue?.identifier, forKey: identifier + " key")
        }
    }
    private var password: String? {
        get {
            return UserDefaults.standard.string(forKey: identifier + " password")
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: identifier + " password")
        }
    }

    var friends = [MRFriend]()
    var profile: MRFriend?
    var invites = [MRInvite]()
    var session: MRSharingSession? {
        didSet {
            if oldValue != session {
                reloadData()
            }
        }
    }

    static func setActiveManager(manager: MSFriendManager) {
        MSFriendManager.manager1.session?.stopPostingLocationUpdates()
        MSFriendManager.manager1.session?.stopListeningForUpdates()
        MSFriendManager.manager2.session?.stopPostingLocationUpdates()
        MSFriendManager.manager2.session?.stopListeningForUpdates()
        MSFriendManager.manager3.session?.stopPostingLocationUpdates()
        MSFriendManager.manager3.session?.stopListeningForUpdates()

        manager.session?.startPostingLocationUpdates()
        manager.session?.startListeningForUpdates()
    }

    func add(observer: MSFriendManagerObserver) {
        if !observers.contains(where: {$0 === observer}) {
            observers.append(observer)
        }
    }

    func remove(observer: MSFriendManagerObserver) {
        observers = observers.filter({$0 !== observer})
    }

    func newAccountWith(password: String, name: String) {
        
        print("name",name)
        print("password",password)
      
        
        MRSharingSession.createAccount(withPassword: password, name: name, appKey: MREditorKey(forMap: mapKeyEEgrab, app: appKeyEEgrab), completion: { [weak self] loginSession, error in
            guard let strongSelf = self else {
                return
            }
            if let thisSession = loginSession {
                strongSelf.friendKey = thisSession.key
                strongSelf.password = password
                strongSelf.session = thisSession
                strongSelf.reloadData()
                
            } else if let thisError = error {
                strongSelf.didFail(error: thisError)
            }
        })
    }

    func deleteAccount() {
        guard let activeSession = session else {
            return
        }
        activeSession.deleteAccount(completion: { [weak self] error in
            if let thisError = error {
                print("Delete account error: " + thisError.localizedDescription)
            } else {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.friendKey = nil
                strongSelf.password = nil
                strongSelf.session = nil
                strongSelf.profile = nil
                strongSelf.friends.removeAll()
                strongSelf.invites.removeAll()
                strongSelf.reloadData()
            }
        })
    }

    func reloadData() {
        if let thisSession = session {
            MRFriend.getAllFriends(with: thisSession, completion: { [weak self] friendResults, error in
                if let friends = friendResults {
                    
                    print("count",friends.count)
                   // print("friends",friends[0].name ?? "Sahenita")
                    //print("friends",friends[0].location?.point.x ?? 0.0)
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.friends = friends
                    strongSelf.didUpdate()
                    // needed to update Data
                    NotificationCenter.default.post(name: Notification.Name("ReloadTableData"),
                                                    object: nil)
                } else if let thisError = error {
                    print("Get all friends error: " + thisError.localizedDescription)
                }
            })

            MRInvite.getAllInvites(with: thisSession, completion: { [weak self]  inviteResults, error in
                if let invites = inviteResults {
                    
                 //   print("invites",invites[0].shareURL)
                     print("count",invites.count)
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.invites = invites
                    strongSelf.didUpdate()
                    // needed to update Data
                    NotificationCenter.default.post(name: Notification.Name("ReloadTableData"),
                                                    object: nil)
                   
                } else if let thisError = error {
                    print("Get all invites error: " + thisError.localizedDescription)
                }
            })

            MRFriend.getWith(thisSession.key, session: thisSession, completion: { [weak self] profileResult, error in
                if let profile = profileResult {
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.profile = profile
                    strongSelf.didUpdate()
                    // needed to update Data
                    NotificationCenter.default.post(name: Notification.Name("ReloadTableData"),
                                                    object: nil)
                } else if let thisError = error {
                    print("Get Friend error: " + thisError.localizedDescription)
                }
            })

            for url in pendingInvites {
                MRInvite.accept(with: url, session: thisSession, completion: { [weak self] friendResult, error in
                    if friendResult != nil {
                        self?.reloadData()
                        // needed to update Data
                        NotificationCenter.default.post(name: Notification.Name("ReloadTableData"),
                                                        object: nil)
                    } else if let thisError = error {
                        print("Accept Invite error: " + thisError.localizedDescription)
                    }
                })
            }
        }

        pendingInvites.removeAll()
        didUpdate()
        
        
       
    }

    private func didUpdate() {
        for observer in observers {
            observer.friendManagerDidUpdate(manager: self)
        }
        NotificationCenter.default.post(name: Notification.Name("ReloadTableData"),
                                        object: nil)
    }

    private func didFail(error: Error) {
        for observer in observers {
            observer.friendManagerDidFailWith(error: error)
        }
    }
}
