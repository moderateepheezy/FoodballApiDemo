//
//  StandingResponse.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

struct StandingResponse: Codable {
    //let competition: Competition?
    //let season: Season?
    let standings: [StandingObject]?
}

// MARK: - Standing
struct StandingObject: Codable {
    let stage, type: String?
    let group: String?
    let table: [TableObject]?
}

// MARK: - Table
struct TableObject: Codable {
    let position: Int?
    let team: TeamObject?
    let playedGames, won, draw, lost: Int?
    let points, goalsFor, goalsAgainst, goalDifference: Int?
}

// MARK: - Team
struct TeamObject: Codable {
    let id: Int?
    let name: String?
    let crestURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case crestURL = "crestUrl"
    }
}
