//
//  NoteController.swift
//  Notes
//
//  Created by Pete Parks on 4/17/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

private var jsonFileName: String = "notes.json"

class NoteController {
    static let sharedInstance = NoteController()
    var notes: [Note] = []
    
    
    
    //CRUD
    // Create
    func create(title: String, details: String) {
        let note = Note(title: title, details: details)
        notes.append(note)
        saveToPersistentStore()
    }
    
    // Delete
    func delete(note: Note) {
        guard let index = notes.firstIndex(of: note) else { return }
        notes.remove(at: index)
        saveToPersistentStore()
    }
    
    // Update
    func update(note: Note, title: String, details: String) {
        note.title = title
        note.details = details
        saveToPersistentStore()
    }
    
    // Move
    func move(indexSource: Int, indexDestination: Int) {
        let note = self.notes.remove(at: indexSource)
        self.notes.insert(note, at: indexDestination)
        saveToPersistentStore()
    }
    
    //MARK: JSON Persistance
    func createJsonFilePersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(url)
        return url[0].appendingPathComponent(jsonFileName)
    }
    
    func saveToPersistentStore() {
        let je = JSONEncoder()
        
        do {
            let jsonEntry = try je.encode(self.notes)
            try jsonEntry.write(to: createJsonFilePersistenceStore())
        } catch let e {
            print("Encoding Error \(e.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jd = JSONDecoder()
        
        do {
            let decodeData = try Data(contentsOf: createJsonFilePersistenceStore())
            self.notes = try jd.decode([Note].self, from: decodeData)
        } catch let e {
            print("Decoding Error \(e.localizedDescription)")
        }
    }
    
}
