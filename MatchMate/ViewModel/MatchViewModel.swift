//
//  MatchViewModel.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation
import CoreData
import Combine

/// ViewModel responsible for managing match data, handling API interactions, and persisting data using Core Data.
class MatchViewModel: ObservableObject {
    /// Published list of matches used to update the UI.
    @Published var matches: [Match] = []
    
    /// A set to store Combine subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// Core Data context for performing database operations.
    private let context: NSManagedObjectContext

    /// Initializes the ViewModel with a Core Data context and fetches stored matches.
    /// - Parameter context: The `NSManagedObjectContext` used for Core Data operations.
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchSavedMatches()
    }

    /// Fetches match data from an API and saves it to Core Data.
    func fetchMatches() {
        APIService.shared.fetchMatches()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("API Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] fetchedMatches in
                self?.saveMatchesToCoreData(fetchedMatches)
            })
            .store(in: &cancellables)
    }

    /// Saves fetched matches to Core Data while preventing duplicates.
    /// - Parameter matches: The list of `Match` objects retrieved from the API.
    private func saveMatchesToCoreData(_ matches: [Match]) {
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
            fetchSavedMatches() // Refresh UI
        } catch {
            print("Core Data Save Error: \(error.localizedDescription)")
        }
    }
    
    /// Retrieves and updates the list of matches from Core Data.
    func fetchSavedMatches() {
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        do {
            let savedEntities = try context.fetch(request)
            self.matches = savedEntities.map {
                Match(
                    id: $0.id?.uuidString ?? UUID().uuidString,
                    name: $0.name ?? "",
                    age: Int($0.age),
                    location: $0.location ?? "",
                    imageUrl: $0.imageUrl ?? "",
                    status: MatchStatus(rawValue: $0.status ?? "none")
                )
            }
        } catch {
            print("Core Data Fetch Error: \(error.localizedDescription)")
        }
    }

    /// Updates the match status (Accept/Decline) and saves it in Core Data.
    /// - Parameters:
    ///   - match: The `Match` object whose status is being updated.
    ///   - status: The new status (`"accepted"` or `"declined"`).
    func updateMatchStatus(match: Match, status: String) {
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", match.id as CVarArg)

        do {
            let results = try context.fetch(request)
            if let entity = results.first {
                entity.status = status
                try context.save()
                fetchSavedMatches() // Refresh UI
            }
        } catch {
            print("Core Data Update Error: \(error.localizedDescription)")
        }
    }
}
