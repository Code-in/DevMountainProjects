//
//  Person.swift
//  PairRandomizer
//
//  Created by Pete Parks on 5/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation


class Person: Codable {
    
    var name: String
    var group: Int
    
    init(name: String, group: Int) {
        self.name = name
        self.group = group
    }
    
}


    // MARK: equality "==" equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.group == rhs.group
    }
}
