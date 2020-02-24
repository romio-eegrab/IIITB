//
//  InviteController.swift
//  IIITB
//
//  Created by Generic Generic on 19/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit
import Meridian


class InviteController: UIViewController,MSFriendManagerObserver {

    
    private enum rowTitles: String {
        case key = "Key"
        case shareURL = "Share URL"
    }
    private var tableLayout: [rowTitles] = [.key, .shareURL]
    var manager: MSFriendManager?
    var inviteKey: MREditorKey?
    var headerView = HeaderView()
    @IBOutlet weak var invitetableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = HeaderView.instanceFromNib() as! HeaderView
        headerView.frame = CGRect(x:0, y: 0, width:self.view.frame.size.width, height: 70)
        headerView.titlelbl.text = "Share Invitation"
        self.view.addSubview(headerView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.backButtonAction(notification:)), name: Notification.Name("BackButtonAction"), object: nil)
        manager?.add(observer: self)
        
        invitetableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingToParent {
            manager?.remove(observer: self)
        }
    }
    @objc func backButtonAction(notification : Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - MSFriendManagerObserver
    
    func friendManagerDidUpdate(manager: MSFriendManager) {
        invitetableView.reloadData()
    }
    
    func friendManagerDidFailWith(error: Error) {
        handleFriendError(error: error)
    }
    
    // MARK: - Utilities
    
    private func getInvite() -> MRInvite? {
        guard let invites = manager?.invites else {
            return nil
        }
        for invite in invites where invite.key == inviteKey {
            return invite
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
extension InviteController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLayout.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        if indexPath.row >= tableLayout.count {
            return cell // Error
        }
        
        if indexPath.row < tableLayout.count {
            cell.titlelbl?.text = tableLayout[indexPath.row].rawValue + " : "
            switch tableLayout[indexPath.row] {
            case .key:
                cell.descriptionlbl?.text = getInvite()?.key.identifier
            case .shareURL:
                cell.descriptionlbl?.text = getInvite()?.shareURL.absoluteString
            }
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < tableLayout.count, let url = getInvite()?.shareURL {
            let activityController = UIActivityViewController.init(activityItems: [url], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 50
        }
        else {
            return 70
        }
    }
    
}
