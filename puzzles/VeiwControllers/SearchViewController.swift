//
//  SearchViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 7/14/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit
import FirebaseFirestore
class SearchViewController: UITableViewController {
    var usernames = [Int: String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var x = 0
                print(x)
                for document in querySnapshot!.documents {
                    print(x*100)
                    db.collection("users").document(document.documentID).collection("profile").getDocuments() { (docs, Error) in
                        if Error != nil {
                            print("Error getting documents")
                        } else {
                            print("5555553434543454433434")
                            for doc in docs!.documents {
                                print("=======================")
                                print(doc.data()["username"]! as Any)
                                print("========================")
                                print(doc.documentID as Any)
                                print("========================")
                                self.usernames[x] = doc.data()["username"] as? String
                                x = x + 1
                            }
                        }
                    }
                }
            }
        }
        print(usernames)
    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tblView: UITableView!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usernames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let tripIndex = indexPath.row
        cell.textLabel?.text = usernames[tripIndex]
        return cell
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
