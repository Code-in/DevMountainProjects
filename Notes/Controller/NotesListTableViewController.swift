//
//  NotesListTableViewController.swift
//  Notes
//
//  Created by Pete Parks on 4/17/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

private var cellIdentifier: String = "noteCell"
private var segueIdentifier: String = "noteSegue"

class NotesListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    // MARK: Instance properties for search
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    var filteredNotesArray = [Note]()
    var resultSearchController = UISearchController()
    
    var isSearchBarEmpty: Bool {
      return resultSearchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = resultSearchController.searchBar.selectedScopeButtonIndex != 0
      return resultSearchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    // MARK: Lifecycle functions
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    override func viewDidLoad() {
        super.viewDidLoad()
        NoteController.sharedInstance.loadFromPersistentStore()
        setUpSearchBar()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        self.tableView.reloadData()
    }
    
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    // MARK: Override to support editing the table view.
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if self.tableView.isEditing == true {
            return .none  // Allows us to edit order of cell items
        } else {
            return .delete // Allows us to delete cell items
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let note = NoteController.sharedInstance.notes[indexPath.row]
            NoteController.sharedInstance.delete(note: note)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        updateView()
    }
    
    // MARK: - Navigation Segue to Details Screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let indexPath = tableView.indexPathForSelectedRow, let dstVC = segue.destination as? NoteDetailViewController else { return }
            let note = NoteController.sharedInstance.notes[indexPath.row]
            dstVC.note = note
        }
    }
    
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    // MARK: Search Bar functions
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    func updateSearchResults(for searchController: UISearchController) {
        filteredNotesArray.removeAll(keepingCapacity: false)
        let searchTerm = searchController.searchBar.text!
        filteredNotesArray = NoteController.sharedInstance.notes.filter { note in
            return note.title.lowercased().contains((searchTerm).lowercased())
        }
        print(filteredNotesArray)
        updateView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (isFiltering) {
            return filteredNotesArray.count
        } else {
            return NoteController.sharedInstance.notes.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let notes: [Note]
        if (isFiltering) {
            notes = filteredNotesArray
        }
        else {
            notes = NoteController.sharedInstance.notes
        }
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    
    func setUpSearchBar() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    // MARK: List Order functions
    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    @IBAction func editRowOrdersAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        NoteController.sharedInstance.move(indexSource: sourceIndexPath.row, indexDestination: destinationIndexPath.row)
    }
    
}
