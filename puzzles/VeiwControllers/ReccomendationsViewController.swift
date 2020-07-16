//
//  ReccomendationsViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 6/26/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ReccomendationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var recs = [String: Dictionary<String, Int>]()
    var recEndorses = [String: Dictionary<String, Array<Any>>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        let db = Firestore.firestore()
        let myViewController: EndorsementsViewController = EndorsementsViewController(nibName: nil, bundle: nil)
        let userEndos = myViewController.endoses
        // this is how u access all the users
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    db.collection("users").document(document.documentID).collection("categories").getDocuments { (qSnap, error) in
                        if error != nil {
                            print("Fault")
                        } else {
                            for doc in querySnapshot!.documents {
                                let othermap = doc.data() as! Dictionary<String, Array<Any>>
                                let ourmap = userEndos[doc.documentID]
                                for keys in othermap {
                                    if ourmap?[keys.key] != nil {
                                        self.recs[doc.documentID] = [document.documentID: self.recs[doc.documentID]?[document.documentID] ?? 1 + 1]
                                    }
                                }
                   
                            }
                        }
                    }
                }
            }
        }
        let z = UInt()
        let x = FirestoreSource(rawValue: z)
        for rec in recs {
            var tempdic = [String: Array<Any>]()
            let sortedDic = rec.value.sorted(by: { $0.value > $1.value })
            for users in sortedDic {
                db.collection("users").document(users.key).collection("categories").document(rec.key).getDocument(source: x!) { (DocumentSnapshot, Error) in
                    let therec = DocumentSnapshot?.data() as! Dictionary<String, Array<Any>>
                    for possiblerecs in therec {
                        if userEndos[rec.key]?[possiblerecs.key] == nil {
                            tempdic[possiblerecs.key] = possiblerecs.value
                        }
                    }
                }
            }
            self.recEndorses[rec.key] = tempdic
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recs.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        let tripIndex = indexPath.row
        var arr = [String]()
        for rec in recs {
            arr = arr + [rec.key]
        }
        cell.textLabel?.text = arr[tripIndex]
        return cell
       }
    
    @IBOutlet weak var tblView: UITableView!
}
