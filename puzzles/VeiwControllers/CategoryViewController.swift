//
//  CategoryViewController.swift
//  puzzles
//
//  Created by Sidharth Daga on 7/15/20.
//  Copyright © 2020 Sidharth Daga. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var nBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    var category: String = ""
    var endorsements: [String: Dictionary<String, Array<Any>>] = [:]
    var endorse = [Int: [String: Array<Any>]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nBar.title = category
        print(category)
        print(endorsements)
        var x = 0
        let v = endorsements[category]
        for endorsem in v! {
            var temp = [String: Array<Any>]()
            temp[endorsem.key] = endorsem.value
            endorse[x] = temp
            x = x + 1
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        endorsements.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellular", for: indexPath)
        var ans = ""
        for key in endorse[indexPath.row]!.keys {
            ans = key
        }
        cell.textLabel?.text = ans
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
