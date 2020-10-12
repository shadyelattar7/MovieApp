//
//  SignUpVC.swift
//  Movie
//
//  Created by Elattar on 9/16/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SignUpVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var userAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let name = userName.text!
        let address = userAddress.text!
        let email = userEmail.text!
        let password = userPassword.text!
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let error = error{
                print("error to signUp at firebase", error.localizedDescription)
                return
            }else{
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let ref = Database.database().reference().child("User").child(uid).child("information")
                let dicValues: [String: Any] = ["UserName": name, "UserEmail": email, "UserAddress": address]
                ref.updateChildValues(dicValues, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        print("failed to push data in Firebase-DB", error.localizedDescription
                        )
                    }else{
                        let def = UserDefaults()
                        def.setValue(name, forKey: "userName")
                        def.setValue(email, forKey: "userEmail")
                        def.setValue(address, forKey: "userAddress")
                        def.synchronize()
                        print("sucessfully update Data in Database")
                    }
                })
            }
        }
        
    }
    
}
