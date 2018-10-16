//
//  RegisterViewController.swift
//  Chat
//
//  Created by hanho on 10/13/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        //Set up a new user on our Firebase database
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Registration Successful!")
                
                SVProgressHUD.dismiss()
                SVProgressHUD.showSuccess(withStatus: "Registration Successful!")
                self.emailTextfield.text = ""
                self.passwordTextfield.text = ""
//                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
