//
//  CoreDataProvider.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MatchMateModel")
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error {
                fatalError("Error Initialising MatchMateModel \(error)")
            }
            
        })
    }
}
