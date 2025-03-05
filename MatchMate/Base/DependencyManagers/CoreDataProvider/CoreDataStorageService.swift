//
//  CoreDataStorageService.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 28/02/25.
//

import Foundation
import CoreData

/// Protocol defining storage operations.
protocol CoreDataProtocol {
    func saveMatches(_ matches: [Match])
    func fetchSavedMatches() -> [Match]
    func updateMatchStatus(matchID: String, status: String)
}

/// Core Data storage implementation of `StorageServiceProtocol`.
final class CoreDataManager: CoreDataProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveMatches(_ matches: [Match]) {
        let fetchRequest: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()

        do {
            let existingMatches = try context.fetch(fetchRequest).compactMap { $0.id?.uuidString }
            
            for match in matches {
                if !existingMatches.contains(match.id) {
                    let newMatch = MatchEntity(context: context)
                    newMatch.id = UUID(uuidString: match.id) ?? UUID()
                    newMatch.name = match.name
                    newMatch.age = Int16(match.age)
                    newMatch.location = match.location
                    newMatch.imageUrl = match.imageUrl
                    newMatch.status = match.status?.rawValue
                }
            }
            try context.save()
        } catch {
            print("Core Data Save Error: \(error.localizedDescription)")
        }
    }

    func fetchSavedMatches() -> [Match] {
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        do {
            let savedEntities = try context.fetch(request)
            return savedEntities.map { $0.toMatch }
        } catch {
            print("Core Data Fetch Error: \(error.localizedDescription)")
            return []
        }
    }

    func updateMatchStatus(matchID: String, status: String) {
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", matchID as CVarArg)

        do {
            let results = try context.fetch(request)
            if let entity = results.first {
                entity.status = status
                try context.save()
            }
        } catch {
            print("Core Data Update Error: \(error.localizedDescription)")
        }
    }
}
