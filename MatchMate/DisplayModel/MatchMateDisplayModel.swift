//
//  MatchMateDisplayModel.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation

/// Represents a match with user details.
struct Match: Identifiable, Codable {
    /// Unique identifier for the match.
    var id: String
    /// Name of the match.
    var name: String?
    /// Age of the match.
    var age: Int
    /// Location of the match.
    var location: String?
    /// Profile image URL of the match.
    var imageUrl: String?
    /// The current status of the match (accepted, declined, or none).
    var status: MatchStatus?
}

/// Represents the possible statuses for a match.
enum MatchStatus: String, Codable {
    /// The match has been accepted.
    case accepted
    /// The match has been declined.
    case declined
    /// The match has no status yet.
    case none
}

// MARK: - Core Data Model

extension MatchEntity {
    /// Converts a `MatchEntity` (Core Data model) to a `Match` struct.
    var toMatch: Match {
        Match(id: self.id?.uuidString ?? UUID().uuidString,
              name: self.name,
              age: Int(self.age),
              location: self.location,
              imageUrl: self.imageUrl,
              status: MatchStatus(rawValue: self.status ?? "none"))
    }
}
