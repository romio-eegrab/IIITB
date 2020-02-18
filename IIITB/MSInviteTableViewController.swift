//
//  MSInviteTableViewController.swift
//  MeridianSwiftSamples
//
//  Created by Stephen Kelly on 5/23/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

import UIKit
import Meridian


class MSInviteTableViewController: UITableViewController, MSFriendManagerObserver {
    var manager: MSFriendManager?
    var inviteKey: MREditorKey?
    var button = UIButton()
    private enum rowTitles: String {
        case key = "Key"
        case shareURL = "Share URL"
    }
    private var tableLayout: [rowTitles] = [.key, .shareURL]

    override func viewDidLoad() {
        super.viewDidLoad()
        manager?.add(observer: self)
        
        button.frame = CGRect(x: 8, y: -30, width: 50, height: 50)
        button.setImage(UIImage(named: "back icon"), for: .normal)
        button.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        self.view.addSubview(button)
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
        if indexPath.row < tableLayout.count {
            cell.textLabel?.text = tableLayout[indexPath.row].rawValue
            switch tableLayout[indexPath.row] {
            case .key:
                cell.detailTextLabel?.text = getInvite()?.key.identifier
            case .shareURL:
                cell.detailTextLabel?.text = getInvite()?.shareURL.absoluteString
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < tableLayout.count, let url = getInvite()?.shareURL {
            let activityController = UIActivityViewController.init(activityItems: [url], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
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

    // MARK: - MSFriendManagerObserver

    func friendManagerDidUpdate(manager: MSFriendManager) {
        tableView.reloadData()
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
