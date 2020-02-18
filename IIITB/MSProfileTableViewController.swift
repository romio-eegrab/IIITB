//
//  MSProfileTableViewController.swift
//  MeridianSwiftSamples
//
//  Created by Stephen Kelly on 5/23/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

import UIKit
import Meridian


class MSProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MSFriendManagerObserver {
    var manager: MSFriendManager?
    var friend: MRFriend?
    var button = UIButton()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        manager?.add(observer: self)
        
        button.frame = CGRect(x: 8, y: -30, width: 50, height: 50)
        button.setImage(UIImage(named: "back icon"), for: .normal)
        button.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        self.view.addSubview(button)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    @objc func logoutUser(){
        // print("clicked")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingToParent {
            manager?.remove(observer: self)
        }
    }

    // MARK: - UITableViewController

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLayout.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: nil)
        if indexPath.row >= tableLayout.count {
            return cell // Error
        }

        cell.textLabel?.text = tableLayout[indexPath.row].rawValue
        if let profile = getProfile() {
            switch tableLayout[indexPath.row] {
            case .key:
                cell.detailTextLabel?.text = profile.key?.identifier
            case .name:
                cell.detailTextLabel?.text = profile.name
            case .profileImage:
                cell.detailTextLabel?.text = profile.imageURL?.absoluteString
            case .sharing:
                cell.detailTextLabel?.text = profile.sharing ? "Yes" : "No"
            case .point:
                if let location = profile.location {
                    cell.detailTextLabel?.text = NSCoder.string(for: location.point)
                }
            case .timestamp:
                cell.detailTextLabel?.text = profile.location?.timestamp.description
            case .distance:
                cell.detailTextLabel?.text = profile.travelDistance?.description
            case .travelTime:
                cell.detailTextLabel?.text = profile.travelTime?.description
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }

    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            UIPasteboard.general.string = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
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
        tableView.reloadData()
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
        
       
        print("Error",error)
        
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
