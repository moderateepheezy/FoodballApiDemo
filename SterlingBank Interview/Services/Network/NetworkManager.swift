//
//  NetworkManager.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation
import Moya

final class NetworkManager {
    
    var storage: StorageContext?
    let provider = MoyaProvider<FootballRequest>()
    
    // MARK: - Fetch Today Fixtures
    /// - parameter matches: closure result response for matches
    /// - parameter message: a success or error message
    func fetchTodayFixtures(completion: @escaping (_ matches: [Match]?, _ message: String) -> ()) {
        let params = ["dateFrom": "2018-07-26", "dateTo": "2018-07-27"]
        provider.request(.todayFixtures(params: params)) { (result) in
            switch result {
            case .success(let value):
                do {
                    print(try value.mapJSON())
                    let matchResponse = try JSONDecoder().decode(FixtureEntity.self, from: value.data)
                    
                    guard let matches = matchResponse.matches else {
                        completion([], "success")
                        return
                    }
                    DatabaseManager<Match>.update(objects: matches)
                    completion(matches, "success")
                    
                } catch let err {
                    print(err.localizedDescription)
                    completion(nil, "Something went wrong!")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func fetchCompetitions(completion: @escaping (_ matches: [Competition]?, _ message: String) -> ()) {
        provider.request(.competitions) { (result) in
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(CompetitionEntity.self, from: response.data)
                    completion(Array(value.competitions), "success")
                    DatabaseManager<CompetitionEntity>.update(object: value)
                } catch let err {
                    print(err.localizedDescription)
                    completion(nil, "Something went wrong!")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func fetchCompetitionStanding(id: String, completion: @escaping (_ tables: [Table]?, _ message: String) -> ()) {
        provider.request(.competitionStanding(id: id)) { (result) in
            switch result {
            case .success(let response):
                do {
                    print(try response.mapJSON())
                    let value = try JSONDecoder().decode(StandingEntity.self, from: response.data)
                    let standing = Array(value.standings).filter {$0.type == "TOTAL"}.map {$0.tables}
                    let tables = standing.count == 0 ? [] : standing[0]
                    DatabaseManager<StandingEntity>.update(object: value)
                    completion(tables, "success")
                } catch let err {
                    print(err.localizedDescription)
                    completion(nil, "Something went wrong!")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func fetchCompetitionFixtures(id: String, completion: @escaping (_ matches: [Match]?, _ message: String) -> ()) {
        provider.request(.matchesForCompetitions(id: id)) { (result) in
            switch result {
            case .success(let value):
                do {
                    print(try value.mapJSON())
                    let matchResponse = try JSONDecoder().decode(FixtureResponse.self, from: value.data)
                    DatabaseManager<FixtureResponse>.update(object: matchResponse)
                    completion(Array(matchResponse.matches), "success")
                } catch let err {
                    print(err.localizedDescription)
                    completion(nil, "Something went wrong!")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func fetchCompetitionTeams(id: String, completion: @escaping (_ matches: [Team]?, _ message: String) -> ()) {
        provider.request(.teamsForCompetitions(id: id)) { (result) in
            switch result {
            case .success(let value):
                do {
                    print(try value.mapJSON())
                    let teamResponse = try JSONDecoder().decode(TeamEntity.self, from: value.data)
                    DatabaseManager<TeamEntity>.update(object: teamResponse)
                    completion(Array(teamResponse.teams), "success")
                } catch let err {
                    print(err.localizedDescription)
                    completion(nil, "Something went wrong!")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func fetchSquadForTeamWith(id: String, completion: @escaping (_ matches: [Squad]?, _ message: String) -> ()) {
        provider.request(.squadFromTeam(id: id)) { (result) in
            switch result {
            case .success(let value):
                do {
                    print(try value.mapJSON())
                    let teamResponse = try JSONDecoder().decode(SquadEntity.self, from: value.data)
                    completion(Array(teamResponse.squad), "success")
                } catch let err {
                    print(err.localizedDescription)
                    completion(nil, "Something went wrong!")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err.localizedDescription)
            }
        }
    }
}
