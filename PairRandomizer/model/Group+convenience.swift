//
//  Group+convenience.swift
//  PairRandomizer
//
//  Created by Pete Parks on 5/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation
import CoreData

extension Group {
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)

        self.name = name
    }
}
