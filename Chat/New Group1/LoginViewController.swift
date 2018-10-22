//
//  LoginViewController.swift
//  Chat
//
//  Created by hanho on 10/13/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                SVProgressHUD.showError(withStatus: "Failed")
            } else {
                //print("Log in successful!")
                
                SVProgressHUD.dismiss()
                SVProgressHUD.showSuccess(withStatus: "Log in successful!")
                
                self.performSegue(withIdentifier: "goToCategory", sender: self)
                
            }
            
        }
    }
    
}
