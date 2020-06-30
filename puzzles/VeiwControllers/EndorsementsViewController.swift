//
//  EndorsementsViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 6/29/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
class EndorsementsViewController: UIViewController {

    
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var endorsments: UITableViewCell!
    @IBOutlet weak var firstNAME: UILabel!
    
    @IBOutlet weak var displayNAME: UILabel!
    
    @IBOutlet weak var lastNAME: UILabel!
    var endoses = [String: Any]()
    var endorsCollectionRef: CollectionReference!
    var profileCollectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        endorsCollectionRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.email as! String).collection("categories")
        profileCollectionRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.email as! String).collection("profile")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        endorsCollectionRef.getDocuments { (snap, error) in
            if let err = error {
                debugPrint("bruh")
            } else {
                for document in snap!.documents {
                   self.endoses = [document.documentID : document.data()]
                }
                for map in self.endoses {
                    self.categories.text = map.key
                }
            }
            
        }
        profileCollectionRef.getDocuments { (snap, error) in
        if let err = error {
            debugPrint("bruh")
        } else {
            for document in snap!.documents {
                print("=========================")
                let data = document.data()
                let username = data["username"] as? String
                let first = data["firstname"] as? String
                let last = data["lastname"] as? String
                self.displayNAME.text = username
                self.firstNAME.text = first
                self.lastNAME.text = last
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
}
}
