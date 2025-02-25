//
//  MatchMateDataModel.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import Foundation

// API Response Models
struct APIResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let dob: DOB
    let location: Location
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
}

struct DOB: Codable {
    let age: Int
}

struct Location: Codable {
    let city: String
}

struct Picture: Codable {
    let large: String
}
