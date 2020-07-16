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
class EndorsementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var firstNAME: UILabel!
    @IBOutlet weak var lastNAME: UILabel!
    
    var cat = ""
    var endoses = [String: Dictionary<String, Array<Any>>]()
    var endorsCollectionRef: CollectionReference!
    var profileCollectionRef: CollectionReference!
    var userEndos = ["Movies", "Books", "TV Shows", "Hikes", "Restaurants", "Artists"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.delegate = self
        tblView.dataSource = self
        print(userEndos)
        print("--------------------")
        endorsCollectionRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.email as! String).collection("categories")
        endorsCollectionRef.getDocuments { (snap, error) in
                  if error != nil {
                      debugPrint("bruh")
                  } else {
                      for document in snap!.documents {
                          self.endoses[document.documentID] = document.data() as? Dictionary
                      }
                  }
              }
            profileCollectionRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.email as! String).collection("profile")
            profileCollectionRef.getDocuments { (snap, error) in
            if error != nil {
                debugPrint("bruh")
            } else {
                for document in snap!.documents {
                    let data = document.data()
                    let username = data["username"] as? String
                    let first = data["firstname"] as? String
                    let last = data["lastname"] as? String
                    self.title = username
                    self.navBar.title = username
                    self.firstNAME.text = first
                    self.lastNAME.text = last
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userEndos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let tripIndex = indexPath.row
        cell.textLabel?.text = userEndos[tripIndex]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainTabController = storyboard?.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        self.view.window?.rootViewController = mainTabController
        self.view.window?.makeKeyAndVisible()
        cat = userEndos[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CategoryViewController
        {
            let vc = segue.destination as? CategoryViewController
            vc?.category = cat
            vc?.endorsements = endoses
        }
    }
}
