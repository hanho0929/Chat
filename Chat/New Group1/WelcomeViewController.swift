//
//  WelcomeViewController.swift
//  Chat
//
//  Created by hanho on 10/13/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "goToChat", sender: self)
        }
    }
    

}
