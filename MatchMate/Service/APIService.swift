//
//  APIService.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation
import Combine

/// A service responsible for fetching match data from a remote API.
class APIService {
    /// Shared singleton instance of `APIService` for global access.
    static let shared = APIService()
    
    /// Private initializer to enforce singleton usage.
    private init() {}

    /// Fetches a list of matches from the API.
    /// - Returns: A publisher that emits an array of `Match` objects or an `Error`.
    func fetchMatches() -> AnyPublisher<[Match], Error> {
        /// API endpoint URL for fetching random user data.
        let url = URL(string: "https://randomuser.me/api/?results=10")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data } // Extract the data from the response.
            .decode(type: APIResponse.self, decoder: JSONDecoder()) // Decode JSON into `APIResponse`.
            .map { response in
                response.results.map {
                    Match(
                        id: UUID().uuidString, // Generate a unique string ID.
                        name: "\($0.name.first) \($0.name.last)",
                        age: $0.dob.age,
                        location: $0.location.city,
                        imageUrl: $0.picture.large,
                        status: MatchStatus.none // Default status to `none`.
                    )
                }
            }
            .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread.
            .eraseToAnyPublisher() // Erase publisher type for flexibility.
    }
}
