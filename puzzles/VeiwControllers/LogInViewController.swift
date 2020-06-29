//
//  LogInViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 6/24/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //gfghfghfgfh

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginTapped(_ sender: Any) {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //self.showError(message: "Please enter all fields")
        }
        if password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //self.showError(message: "Please enter all fields")
        }
        
        let mail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: mail, password: pass) { (result, error) in
            if error != nil {
                self.error.text = error!.localizedDescription
                self.error.alpha = 1
            } else {
                let mainTabController = self.storyboard?.instantiateViewController(identifier: "MainTabController") as! MainTabController
                self.view.window?.rootViewController = mainTabController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
