//
//  ProfileController.swift
//  IIITB
//
//  Created by Generic Generic on 19/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit
import Meridian

class ProfileController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, MSFriendManagerObserver {

    var manager: MSFriendManager?
    var friend: MRFriend?
    var headerView = HeaderView()
    
    
    private enum rowTitles: String {
        case key = "Key"
        case name = "Name"
        case profileImage = "Profile Image"
        case sharing = "Sharing"
        case point = "Point"
        case timestamp = "Timestamp"
        case distance = "Distance"
        case travelTime = "Travel Time"
    }
    private var tableLayout: [rowTitles] = [.key,
                                            .name,
                                            .profileImage,
                                            .sharing,
                                            .point,
                                            .timestamp,
                                            .distance,
                                            .travelTime]
    
    
    @IBOutlet weak var profileTblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        headerView = HeaderView.instanceFromNib() as! HeaderView
        headerView.frame = CGRect(x:0, y: 0, width:self.view.frame.size.width, height: 70)
        self.view.addSubview(headerView)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.backButtonAction(notification:)), name: Notification.Name("BackButtonAction"), object: nil)
         manager?.add(observer: self)
        
        profileTblView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        profileTblView.dataSource = self
        profileTblView.delegate = self
    }
    
    @objc func backButtonAction(notification : Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingToParent {
            manager?.remove(observer: self)
        }
    }
    

    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let session = manager?.session, let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            getProfile()?.uploadImage(image, with: session, completion: { [weak self] _, error in
                if let uploadError = error {
                    self?.handleFriendError(error: uploadError)
                } else {
                    self?.manager?.reloadData()
                }
            })
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - MSFriendManagerObserver
    
    func friendManagerDidUpdate(manager: MSFriendManager) {
        profileTblView.reloadData()
    }
    
    func friendManagerDidFailWith(error: Error) {
        handleFriendError(error: error)
    }
    
    // MARK: - Utilities
    
    private func getProfile() -> MRFriend? {
        guard let myFriend = friend, let friendManager = manager else {
            return manager?.profile
        }
        for friend in friendManager.friends where friend.key == myFriend.key {
            return friend
        }
        return nil
    }
    
    private func handleFriendError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
extension ProfileController : UITableViewDataSource,UITableViewDelegate {
    
    // MARK: - UITableViewController
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLayout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        if indexPath.row >= tableLayout.count {
            return cell // Error
        }
        
       // cell.textLabel?.text = tableLayout[indexPath.row].rawValue
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        
        if let profile = getProfile() {
            switch tableLayout[indexPath.row] {
            case .key:
               // cell.detailTextLabel?.text = profile.key?.identifier
                cell.showlbl.text = tableLayout[indexPath.row].rawValue + " : " + ( profile.key?.identifier ?? " " )
            case .name:
                cell.showlbl.text =  tableLayout[indexPath.row].rawValue + " : " + ( profile.name ?? " " )
            case .profileImage:
                cell.showlbl?.text =  tableLayout[indexPath.row].rawValue + " : " + ( profile.imageURL?.absoluteString ?? " " )
            case .sharing:
                cell.showlbl?.text =  tableLayout[indexPath.row].rawValue + " : " + (profile.sharing ? "Yes" : "No")
            case .point:
                cell.showlbl?.text = tableLayout[indexPath.row].rawValue + " : "
                if let location = profile.location {
                    cell.showlbl?.text = tableLayout[indexPath.row].rawValue + " : " +  (NSCoder.string(for: location.point))
                }
            case .timestamp:
                cell.showlbl?.text = tableLayout[indexPath.row].rawValue + " : " + ( profile.location?.timestamp.description ?? " ")
            case .distance:
                cell.showlbl?.text =  tableLayout[indexPath.row].rawValue + " : " + (profile.travelDistance?.description ?? " ")
            case .travelTime:
                cell.showlbl?.text = tableLayout[indexPath.row].rawValue + " : " + ( profile.travelTime?.description ?? " ")
            }
            cell.showlbl.tintColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= tableLayout.count {
            return // Error
        }
        
        switch tableLayout[indexPath.row] {
        case .name:
            let alert = UIAlertController(title: "Update Name", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in textField.placeholder = "Name" }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
                if let alertText = alert?.textFields?[0].text, alertText.count > 0 {
                    guard let session = self?.manager?.session else {
                        return
                    }
                    self?.getProfile()?.updateName(alertText, with: session, completion: { _, error in
                        if let updateError = error {
                            self?.handleFriendError(error: updateError)
                        } else {
                            self?.manager?.reloadData()
                        }
                    })
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        case .profileImage:
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        case .sharing:
            guard let session = manager?.session else {
                break
            }
            getProfile()?.disableSharing(with: session, completion: {[weak self] _, error in
                if let disableError = error {
                    self?.handleFriendError(error: disableError)
                } else {
                    self?.manager?.reloadData()
                }
            })
        case .point:
            let alert = UIAlertController(title: "Update Location", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in textField.placeholder = "x" }
            alert.addTextField { (textField) in textField.placeholder = "y" }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] (_) in
                if let xText = alert?.textFields?[0].text, let xValue = Double(xText),
                    let yText = alert?.textFields?[1].text, let yValue = Double(yText) {
                    
                    guard let strongSelf = self else {
                        return
                    }
                    if let session = strongSelf.manager?.session {
                        let mapKey = MREditorKey(forMap: mapKeyEEgrab, app: appKeyEEgrab)
                        let offset = CGPoint(x: xValue, y: yValue)
                        strongSelf.getProfile()?.updateLocation(mapKey, mapOffset: offset, with: session, completion: {[weak self] _, error in
                            if let disableError = error {
                                self?.handleFriendError(error: disableError)
                            } else {
                                self?.manager?.reloadData()
                            }
                        })
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            UIPasteboard.general.string = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
        }
    }
    
}
