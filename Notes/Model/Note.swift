//
//  Note.swift
//  Notes
//
//  Created by Pete Parks on 4/17/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

class Note : Codable {
    var title: String
    var details: String
    
    init(title: String, details: String) {
        self.title = title
        self.details = details
    }
    
}

extension Note: Equatable {
    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.title == rhs.title && lhs.details == rhs.details
    }
}
