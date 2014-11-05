//
//  AccountViewController.swift
//  PetPal
//
//  Created by Haavar Valeur on 10/20/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {


    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = appContext.authContext.emailAddress
    }

    @IBAction func logoutClicked(sender: UIButton) {
        appContext.authContext.logout()
        self.performSegueWithIdentifier("go_login", sender: self)

    }
}