//
//  PairedTableViewController.swift
//  PairRandomizer
//
//  Created by Pete Parks on 5/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class PairedTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.shared.loadFromPersistentStore()
        print("Count: \(PersonController.shared.people.count)")
        
        for person in PersonController.shared.people {
            print("Person: \(person.name)")
            print("Person: \(person.group)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let half = PersonController.shared.people.count/2
        let sections: Int = half * 2  < PersonController.shared.people.count ? half + 1 : half
        print("sections: \(sections)")
        return sections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let half = PersonController.shared.people.count/2
        let calcSections: Int = half * 2  < PersonController.shared.people.count ? half + 1 : half
        let outSection  = calcSections == (section + 1) ? 1 : 2
        return outSection
    } 
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        
        for person in PersonController.shared.people {
            if person.group == indexPath.section {
                print("indexPath: \(indexPath.row)")
                cell.textLabel?.text = person.name
            }
        }
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    
    @IBAction func addPersonAction(_ sender: Any) {
        addPersonToListAlert()
        updateView()
    }
    
    func addPersonToListAlert() {
        let alertController = UIAlertController(title: "Add people", message: "Please add a person to your paired list", preferredStyle: .alert)
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Person to add"
        }
        let addBrunchSpotAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let half = PersonController.shared.people.count/2
            let sections: Int = half * 2  < PersonController.shared.people.count ? half + 1 : half
            let groupName = sections
            guard let name = alertController.textFields?[0].text else { return }
            PersonController.shared.add(name: name, group: groupName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addBrunchSpotAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
    
}
