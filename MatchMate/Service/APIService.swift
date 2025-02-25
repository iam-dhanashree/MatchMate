//
//  APIService.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    private init() {}

    func fetchMatches() -> AnyPublisher<[Match], Error> {
        let url = URL(string: "https://randomuser.me/api/?results=10")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map { response in
                response.results.map {
                    Match(
                        id: UUID().uuidString, // ✅ Ensure String ID
                        name: "\($0.name.first) \($0.name.last)",
                        age: $0.dob.age,
                        location: $0.location.city,
                        imageUrl: $0.picture.large,
                        status: MatchStatus.none
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
