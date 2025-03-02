//
//  MatchDataModel.swift
//  Match
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation

/// Represents the API response containing a list of users.
struct APIResponse: Codable {
    /// An array of `User` objects retrieved from the API.
    let results: [User]
}

/// Represents a user in the API response.
struct User: Codable {
    let name: Name
    let dob: DOB
    let location: Location
    let picture: Picture
}

/// Represents the name details of a user.
struct Name: Codable {
    let first: String
    let last: String
}

/// Represents the date of birth details of a user.
struct DOB: Codable {
    let age: Int
}

/// Represents the location details of a user.
struct Location: Codable {
    let city: String
}

/// Represents the profile picture of a user.
struct Picture: Codable {
    let large: String
}
