//
//  MatchViewModel.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation
import CoreData
import Combine

/// ViewModel responsible for managing match data.
class MatchViewModel: ObservableObject {
    @Published var matches: [Match] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    private let storageService: StorageServiceProtocol

    /// Initializes ViewModel with dependency injection.
    /// - Parameters:
    ///   - apiService: API service implementing `APIServiceProtocol`.
    ///   - storageService: Storage service implementing `StorageServiceProtocol`.
    init(apiService: APIServiceProtocol,
         storageService: StorageServiceProtocol) {
        self.apiService = apiService
        self.storageService = storageService
        fetchSavedMatches()
    }

    /// Fetches match data from the API and saves it.
    func fetchMatches() {
        apiService.fetchMatches()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("API Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] fetchedMatches in
                self?.storageService.saveMatches(fetchedMatches)
                self?.fetchSavedMatches()
            })
            .store(in: &cancellables)
    }

    /// Retrieves stored matches and updates UI.
    func fetchSavedMatches() {
        matches = storageService.fetchSavedMatches()
    }

    /// Updates match status.
    func updateMatchStatus(match: Match, status: MatchStatus) {
        storageService.updateMatchStatus(matchID: match.id, status: status.rawValue)
        fetchSavedMatches()
    }
}
