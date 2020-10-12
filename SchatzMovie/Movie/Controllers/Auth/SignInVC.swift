//
//  SignInVC.swift
//  Movie
//
//  Created by Elattar on 9/16/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signIn(_ sender: Any) {
        
         let emailTxt = email.text!
         let passTxt = password.text!
        
        Auth.auth().signIn(withEmail: emailTxt, password: passTxt) { (user, error) in
            if let error = error{
                print("failed to SignIn", error.localizedDescription)
                return
            }else if let user = user{
                print("successfully SignIn", user.user.email ?? "")
            }
        }
    }
    

}
