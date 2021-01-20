//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Pete Parks on 5/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

private var jsonFileName: String = "paired.json"

class PersonController {
    
    static let shared = PersonController()
    
    // MARK: CRUD
    var people: [Person] = []
    
    // MARK: Create
    func add(name: String, group: Int) {
        let person = Person(name: name, group: group)
        people.append(person)
        print("Person Added")
        saveToPersistentStore()
    }
    
    // MARK: Delete
    func delete(person: Person) {
        guard let personIndex = people.firstIndex(of: person) else { return }
        people.remove(at: personIndex)
        saveToPersistentStore()
    }
    
    
    
    func createJsonFilePersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(url)
        return url[0].appendingPathComponent(jsonFileName)
    }
    
    func saveToPersistentStore() {
        let je = JSONEncoder()
        
        do {
            let jsonPeople = try je.encode(self.people)
            try jsonPeople.write(to: createJsonFilePersistenceStore())
        } catch let e {
            print("Encoding Error \(e.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jd = JSONDecoder()
        
        do {
            let decodeData = try Data(contentsOf: createJsonFilePersistenceStore())
            self.people = try jd.decode([Person].self, from: decodeData)
        } catch let e {
            print("Decoding Error \(e.localizedDescription)")
        }
    }
}
