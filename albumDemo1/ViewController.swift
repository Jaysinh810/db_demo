//
//  ViewController.swift
//  albumDemo1
//
//  Created by Jay on 01/07/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: ------------------------- IBOUTLETS -------------------------
    
    @IBOutlet weak var albumTable: UITableView!
    
    var db:DBHelper = DBHelper()
    var persons:[Person] = []
    
    
    //MARK: ------------------------- VIEWDIDLOAD -------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.albumTable.delegate = self
        self.albumTable.dataSource = self
        
        db.insert(id: 1, name: "John", age: 24, imageUrl: <#String#>)
        db.insert(id: 2, name: "Thor", age: 25, imageUrl: <#String#>)
        db.insert(id: 3, name: "Edward", age: 22, imageUrl: <#String#>)
        db.insert(id: 4, name: "Ronald", age: 44, imageUrl: <#String#>)
        
        persons = db.read()
    }
    
    
    //MARK: ------------------------- IBACTIONS -------------------------
    
    
    
    //MARK: ------------------------- FUNCTIONS -------------------------
    
    
    
    //MARK: ------------------------- DELEGATES -------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.albumTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Name: " + persons[indexPath.row].name + ", Age: " + String(persons[indexPath.row].age)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    


}

