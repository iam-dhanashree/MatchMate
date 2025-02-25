//
//  MatchMateDisplayModel.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation

struct Match: Identifiable, Codable {
    var id: String
    var name: String?
    var age: Int
    var location: String?
    var imageUrl: String?
    var status: MatchStatus?
}

enum MatchStatus: String, Codable {
    case accepted, declined, none
}

// MARK: - Core Data Model
extension MatchEntity {
    var toMatch: Match {
        Match(id: self.id?.uuidString ?? UUID().uuidString,
              name: self.name,
              age: Int(self.age),
              location: self.location,
              imageUrl: self.imageUrl,
              status: MatchStatus(rawValue: self.status ?? "none"))
    }
}
