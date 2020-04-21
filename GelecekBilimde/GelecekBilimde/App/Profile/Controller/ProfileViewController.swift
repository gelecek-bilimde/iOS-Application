//
//  ProfileViewController.swift
//  GelecekBilimde
//
//  Created by Burak Furkan Asilturk on 30.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import SDWebImage
import SafariServices

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var profileDataSourceAndDelegate: ProfileDataSourceAndDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileDataSourceAndDelegate = ProfileDataSourceAndDelegate(vc: self)
        setView()
    }
}

// MARK: - Auxiliary Methods
extension ProfileViewController {
    func setView(){
        //NavBar title customizations
        navigationController?.navigationBar.barTintColor = UIColor.barTintColor
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        //Set table view delegate and data source
        tableView.delegate = profileDataSourceAndDelegate
        tableView.dataSource = profileDataSourceAndDelegate
        //Set view controller
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageView.clipsToBounds = true
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.borderWidth = 1
        usernameLabel.text = CurrentUser.currentUser.name
        if CurrentUser.currentUser.photoURL != "" {
            guard let url = URL(string: CurrentUser.currentUser.photoURL) else { return }
            userImageView.sd_setImage(with: url)
        }
    }
}
