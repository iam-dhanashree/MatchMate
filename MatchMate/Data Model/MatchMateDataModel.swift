//
//  MatchMateDataModel.swift
//  MatchMate
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
    /// The user's name details.
    let name: Name
    /// The user's date of birth details.
    let dob: DOB
    /// The user's location details.
    let location: Location
    /// The user's profile picture.
    let picture: Picture
}

/// Represents the name details of a user.
struct Name: Codable {
    /// The user's first name.
    let first: String
    /// The user's last name.
    let last: String
}

/// Represents the date of birth details of a user.
struct DOB: Codable {
    /// The user's age in years.
    let age: Int
}

/// Represents the location details of a user.
struct Location: Codable {
    /// The city where the user is located.
    let city: String
}

/// Represents the profile picture of a user.
struct Picture: Codable {
    /// URL string of the user's large-sized profile picture.
    let large: String
}
