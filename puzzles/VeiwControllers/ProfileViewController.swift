//
//  ProfileViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 6/26/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var link: UITextField!
    @IBOutlet weak var endorsement: UITextField!
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.categorypicker.delegate = self
        self.categorypicker.dataSource = self
        pickerData = ["Movies", "Books", "TV Shows", "Hikes", "Restaurants", "Artists"]
    }
    
    @IBAction func AddedEndorsement(_ sender: Any) {
       
        let selectCateg = pickerView(category, titleForRow: 1, forComponent: 4)
        let selectLink = link.text!
        let selectEndors = endorsement.text!
        let db = Firestore.firestore()
        db.collection("users").document("s").setData(["boon" : "BOON"], merge: true)
        let uservc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        print(uservc.username)
        print(uservc.firstName)
        let uid = uservc.username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //self.ref?.child("users").childByAutoId().setValue(selectEndors)
        //presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var categorypicker: UIPickerView!
    var pickerData: [String] = [String]()
    
    @IBAction func logout(_ sender: Any) {
        let homescreen = storyboard?.instantiateViewController(identifier: "LogInViewController") as! LogInViewController
        self.view.window?.rootViewController = homescreen
        self.view.window?.makeKeyAndVisible()
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
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
