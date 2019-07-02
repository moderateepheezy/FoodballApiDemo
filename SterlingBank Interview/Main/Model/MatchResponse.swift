//
//  MatchResponse.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - MatchResponse
struct MatchResponse: Codable {
    let count: Int?
    let matches: [MatchObject]?
}

// MARK: - Match
struct MatchObject: Codable {
    let id: Int
    let competition: CompetitionObject?
    let status: String?
    let utcDate: String?
    let score: ScoreObject?
    let homeTeam, awayTeam: TeamObject?
}

// MARK: - Score
struct ScoreObject: Codable {
    let winner, duration: String?
    let fullTime, halfTime: ScoreTimeObject?
}

// MARK: - ExtraTime
struct ScoreTimeObject: Codable {
    let homeTeam, awayTeam: Int?
}

