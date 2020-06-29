//
//  SignUpViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 6/24/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        if lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        if password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        if passwordTest.evaluate(with: cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains, a special character, and a number"
        }
        return nil
    }


    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(message: error!)
        } else {
            let firstN = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastN = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let gmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let user = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: gmail, password: pass) { (result, err) in
                if err != nil {
                    self.showError(message: "Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").document(gmail).setData( ["firstname": firstN, "lastname": lastN, "uid": result!.user.uid, "username" : user]) { (error) in
                        if error != nil {
                            self.showError(message: "Error saving user data")
                        }
                    }
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError( message:String) {
        error.text = message
        error.alpha = 1
    }
    
    func transitionToHome() {
        let mainTabController = storyboard?.instantiateViewController(identifier: "MainTabController") as! MainTabController
        self.view.window?.rootViewController = mainTabController
        self.view.window?.makeKeyAndVisible()
    }
}
