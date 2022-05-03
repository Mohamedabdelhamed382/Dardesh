//
//  SettingsTableViewController.swift
//  Dardesh
//
//  Created by MOHAMED ABD ELHAMED AHMED on 02/05/2022.
//

import UIKit
import NVActivityIndicatorView

class SettingsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var avaterImageOutlet: UIImageView!
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet weak var statusLabelOutlets: UILabel!
    @IBOutlet weak var AppVersionLabelOutlet: UILabel!
    
    //MARK: - LifeCycleOfTableView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showUserInfo()
    }
//MARK: - IBActions
    @IBAction func tellFriendButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func termsAndConditionButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        startLoadingIndicator()
        logoutCurrentUser()
    }
}

//MARK: -  Methos
extension SettingsTableViewController {
    
    func layoutConfiguration() {
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - updateUserInterface
    private func showUserInfo() {
        if let user = User.currentUser {
            usernameLabelOutlet.text = user.username
            statusLabelOutlets.text  = user.status
            AppVersionLabelOutlet.text = "App Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
            
            if user.avatarLink != "" {
                //MARK: - TODO Download and set user image
            }
        }
    }
    
    //MARK: - Logout CurrentUser
    private func logoutCurrentUser() {
              FUserListener.shared.logOutCurrentuser { error in
            if error == nil {
                let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
                self.stopLoadingIndicator()
            }
        }
    }
}

//MARK: - tableViewDelegates
extension SettingsTableViewController {

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "colorTableView")

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 10.0
    }
}
