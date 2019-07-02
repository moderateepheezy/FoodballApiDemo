//
//  SquadResponse.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

// MARK: - SquadResponse
struct SquadResponse: Codable {
    let id: Int
    let name, shortName, tla: String
    let crestURL: String
    let squad: [SquadObject]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, shortName, tla
        case crestURL = "crestUrl"
        case squad
    }
}

// MARK: - Squad
struct SquadObject: Codable {
    let id: Int
    let name: String
    let position: Position?
    let role: Role
}

// MARK: - Player Position
enum Position: String, Codable {
    case attacker = "Attacker"
    case defender = "Defender"
    case goalkeeper = "Goalkeeper"
    case midfielder = "Midfielder"
}

// MARK: - Player Role
enum Role: String, Codable {
    case assistantCoach = "ASSISTANT_COACH"
    case coach = "COACH"
    case player = "PLAYER"
    case scout = "SCOUT"
}
