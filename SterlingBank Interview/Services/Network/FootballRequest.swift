//
//  FootballRequest.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation
import Moya

typealias Params = [String: Any]

enum FootballRequest: TargetType {
    case todayFixtures(params: Params)
    case competitions
    case competitionStanding(id: String)
    case matchesForCompetitions(id: String)
    case teamsForCompetitions(id: String)
    case squadFromTeam(id: String)
}

extension FootballRequest{
    
    var baseURL: URL {
        return URL(string: "https://api.football-data.org/v2/")!
    }
    
    var path: String {
        switch self {
        case .todayFixtures:
            return "matches"
        case .competitions:
            return "competitions"
        case .competitionStanding(let id):
            return "competitions/\(id)/standings"
        case .matchesForCompetitions(let id):
            return "competitions/\(id)/matches"
        case .teamsForCompetitions(let id):
            return "competitions/\(id)/teams"
        case .squadFromTeam(let id):
            return "teams/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .todayFixtures,
             .competitions,
             .competitionStanding,
             .matchesForCompetitions,
             .teamsForCompetitions,
             .squadFromTeam:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .todayFixtures(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .competitions,
             .competitionStanding,
             .matchesForCompetitions,
             .teamsForCompetitions,
             .squadFromTeam:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["X-Auth-Token": "c92869153b504e83a12ee6713b100e7d"]
    }
}
