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
class EndorsementsViewController: UIViewController{

    

    @IBOutlet weak var firstNAME: UILabel!
    
    @IBOutlet weak var displayNAME: UILabel!
    
    @IBOutlet weak var lastNAME: UILabel!
    
    var endoses = [String: Dictionary<String, Array<Any>>]()
    var endorsCollectionRef: CollectionReference!
    var profileCollectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        endorsCollectionRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.email as! String).collection("categories")
        endorsCollectionRef.getDocuments { (snap, error) in
                  if error != nil {
                      debugPrint("bruh")
                  } else {
                      for document in snap!.documents {
                          self.endoses[document.documentID] = document.data() as? Dictionary
                      }
                    let cent = self.view.center
                    let xcor = cent.x
                    var ycor = cent.y - 100
                      for map in self.endoses {
                        let category = UILabel()
                        var times = 0
                        category.text = map.key
                        category.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
                        category.center = CGPoint(x: xcor, y: ycor)
                        category.backgroundColor = UIColor.yellow
                        category.textAlignment = .center
                        self.view.addSubview(category)
                        let names = UILabel()
                        names.text = ""
                        for cat in map.value {
                            names.text! += cat.key + "\n"
                            names.text! += (cat.value[0] as! String) + "\n"
                            let mycount = cat.value[1] as! Int
                            names.text! += "Count: " + String(mycount) + "\n"
                            times += 1
                          }
                        names.numberOfLines = 3 * times
                        names.frame = CGRect(x: 0, y: 0, width: 100, height: 75 * times)
                        names.center = CGPoint(x: xcor, y: ycor + CGFloat(75 * times))
                        names.backgroundColor = UIColor.red
                        self.view.addSubview(names)
                        ycor += CGFloat(150 * times)
                      }
                    
                  }
              }
            profileCollectionRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.email as! String).collection("profile")
            profileCollectionRef.getDocuments { (snap, error) in
            if let err = error {
                debugPrint("bruh")
            } else {
                for document in snap!.documents {
                    let data = document.data()
                    let username = data["username"] as? String
                    let first = data["firstname"] as? String
                    let last = data["lastname"] as? String
                    self.title = username
                    self.displayNAME.text = username
                    self.firstNAME.text = first
                    self.lastNAME.text = last
                }
            }
     

            }
    }
    
}
