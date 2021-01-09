//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Pete Parks on 4/17/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    @IBOutlet weak var notesTextViewOutlet: UITextView!
    
    
    // MARK: Properties
    var note: Note? {
        didSet {
            updateViews()
        }
    }

    // MARK: Lifecylce functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let note = self.note, self.isViewLoaded else { return }
        notesTextViewOutlet.text = note.details
    }
    
    // Mark: Crete title string
    func buildSubStringTitle() -> String? {
        guard let details = notesTextViewOutlet.text, !details.isEmpty else {
            print("Getting string from UI failed")
            return nil
        }
        return String(details.prefix(32))
    }
    
    // MARK: IBAction
    @IBAction func saveButtonTappedAction(_ sender: UIBarButtonItem) {
        
        guard let details = notesTextViewOutlet.text, !details.isEmpty else {
            print("Getting string from UI failed")
            return
        }
        let title = buildSubStringTitle() ?? "New Note"
        
        if let note = self.note {
            NoteController.sharedInstance.update(note: note, title: title, details: details)
        } else {
            NoteController.sharedInstance.create(title: String(title), details: details)
        }
        notesTextViewOutlet.text = ""
        
        self.navigationController?.popViewController(animated: true)
    }

}
