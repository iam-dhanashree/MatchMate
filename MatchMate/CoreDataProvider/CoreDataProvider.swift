//
//  CoreDataProvider.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation
import CoreData

/// Singleton class responsible for managing the Core Data stack.
class CoreDataProvider {
    
    /// Shared instance of `CoreDataProvider` to ensure a single point of access.
    static let shared = CoreDataProvider()
    
    /// The persistent container that loads and manages the Core Data stack.
    let persistentContainer: NSPersistentContainer
    
    /// Private initializer to enforce singleton usage and load the Core Data store.
    private init() {
        persistentContainer = NSPersistentContainer(name: "MatchMateModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing MatchMateModel: \(error)")
            }
        }
    }
}
