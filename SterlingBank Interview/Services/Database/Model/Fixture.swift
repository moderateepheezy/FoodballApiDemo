//
//  Fixture.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/28/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class FixtureResponse: Object, Codable {
    @objc dynamic var count: Int = 0
    @objc dynamic var competition: Competition? = nil
    let matches = List<Match>()
    
    @objc dynamic var code: String = ""
    
    var matchList: [Match] {
        return Array(matches)
    }
    
    override public static func primaryKey() -> String? {
        return "code"
    }
    
    init(count: Int,competition: Competition?, matches: [Match]) {
        super.init()
        self.count = count
        self.competition = competition
        self.matches.append(objectsIn: matches)
    }
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case matches = "matches"
        case competition = "competition"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        count = (try container.decodeIfPresent(Int.self, forKey: .count)) ?? 0
        competition = try container.decodeIfPresent(Competition.self, forKey: .competition)
        code = competition?.code ?? ""
        if let matches = (try container.decodeIfPresent([Match].self, forKey: .matches)) {
            self.matches.append(objectsIn: matches)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class FixtureEntity: Codable {
    let count: Int
    let competition: Competition?
    let matches: [Match]?
}

class CompetitionEntity: Object, Codable {
    @objc dynamic var count: Int = 0
    let competitions = List<Competition>()
    
    override public static func primaryKey() -> String? {
        return "count"
    }
    
    init(count: Int, competitions: [Competition]) {
        super.init()
        self.count = count
        self.competitions.append(objectsIn: competitions)
    }
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case competitions = "competitions"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        count = (try container.decodeIfPresent(Int.self, forKey: .count)) ?? 0
        if let competitions = (try container.decodeIfPresent([Competition].self, forKey: .competitions)) {
            self.competitions.append(objectsIn: competitions)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class StandingEntity: Object, Codable {
    @objc dynamic var competition: Competition? = nil
    let standings = List<Standing>()
    
    var standingArray: [Standing] {
        return Array(standings)
    }
    
    @objc dynamic var code: String = ""
    
    override public static func primaryKey() -> String? {
        return "code"
    }
    
    init(competition: Competition, standings: [Standing]) {
        super.init()
        self.standings.append(objectsIn: standings)
        self.competition = competition
    }
    
    enum CodingKeys: String, CodingKey {
        case standings = "standings"
        case competition = "competition"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        competition = (try container.decodeIfPresent(Competition.self, forKey: .competition))
        code = competition?.code ?? ""
        if let standings = (try container.decodeIfPresent([Standing].self, forKey: .standings)) {
            self.standings.append(objectsIn: standings)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class TeamEntity: Object, Codable {
    @objc dynamic var competition: Competition? = nil
    let teams = List<Team>()
    
    @objc dynamic var code: String = ""
    
    override public static func primaryKey() -> String? {
        return "code"
    }
    
    var teamArray: [Team] {
         return Array(teams)
    }
    
    init(teams: [Team]) {
        super.init()
        self.teams.append(objectsIn: teams)
    }
    
    enum CodingKeys: String, CodingKey {
        case teams = "teams"
        case competition
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        competition = (try container.decodeIfPresent(Competition.self, forKey: .competition))
        code = competition?.code ?? ""
        if let teams = (try container.decodeIfPresent([Team].self, forKey: .teams)) {
            self.teams.append(objectsIn: teams)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class SquadEntity: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var shortName: String = ""
    @objc dynamic var tla: String = ""
    @objc dynamic var crestURL: String = ""
    let squad = List<Squad>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int, name: String, shortName: String, tla: String, crestURL: String, squad: [Squad]) {
        super.init()
        self.id = id
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.crestURL = crestURL
        self.squad.append(objectsIn: squad)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, shortName, tla
        case squad = "squad"
        case crestURL = "crestUrl"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        name = (try container.decodeIfPresent(String.self, forKey: .name)) ?? ""
        shortName = (try container.decodeIfPresent(String.self, forKey: .shortName)) ?? ""
        tla = (try container.decodeIfPresent(String.self, forKey: .tla)) ?? ""
        crestURL = (try container.decodeIfPresent(String.self, forKey: .crestURL)) ?? ""
        if let squad = (try container.decodeIfPresent([Squad].self, forKey: .squad)) {
            self.squad.append(objectsIn: squad)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Squad: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var position: String = ""
    @objc dynamic var role: String = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int, name: String, position: String, role: String) {
        super.init()
        self.id = id
        self.name = name
        self.position = position
        self.role = role
    }
    
    enum CodingKeys: String, CodingKey {
        case id, position, name, role
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        name = (try container.decodeIfPresent(String.self, forKey: .name)) ?? ""
        position = (try container.decodeIfPresent(String.self, forKey: .position)) ?? ""
        role = (try container.decodeIfPresent(String.self, forKey: .role)) ?? ""
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Standing: Object, Codable {
    @objc dynamic var stage: String = ""
    @objc dynamic var type: String = ""
    let table = List<Table>()
    
    var tables: [Table] {
        return Array(table)
    }
    
    init(stage: String, type: String, table: [Table]) {
        super.init()
        self.stage = stage
        self.type = type
        self.table.append(objectsIn: table)
    }
    
    enum CodingKeys: String, CodingKey {
        case stage, type, table
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stage = (try container.decodeIfPresent(String.self, forKey: .stage)) ?? ""
        type = (try container.decodeIfPresent(String.self, forKey: .type)) ?? ""
        if let table = (try container.decodeIfPresent([Table].self, forKey: .table)) {
            self.table.append(objectsIn: table)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Table: Object, Codable {
    @objc dynamic var position: Int = 0
    @objc dynamic var team: Team? = nil
    @objc dynamic var playedGames: Int = 0
    @objc dynamic var won: Int = 0
    @objc dynamic var draw: Int = 0
    @objc dynamic var lost: Int = 0
    @objc dynamic var points: Int = 0
    @objc dynamic var goalsFor: Int = 0
    @objc dynamic var goalsAgainst: Int = 0
    @objc dynamic var goalDifference: Int = 0
    
    init(position: Int, team: Team, playedGames: Int,
         won: Int, draw: Int, lost: Int, points: Int, goalsFor: Int, goalsAgainst: Int, goalDifference: Int) {
        super.init()
        self.position = position
        self.team = team
        self.playedGames = playedGames
        self.won = won
        self.draw = draw
        self.lost = lost
        self.points = points
        self.goalsFor = goalsFor
        self.goalsAgainst = goalsAgainst
        self.goalDifference = goalDifference
    }
    
    enum CodingKeys: String, CodingKey {
        case position, team, playedGames, won,
        draw, lost, points, goalsFor, goalsAgainst, goalDifference
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        position = (try container.decodeIfPresent(Int.self, forKey: .position)) ?? 0
        team = (try container.decodeIfPresent(Team.self, forKey: .team))
        playedGames = (try container.decodeIfPresent(Int.self, forKey: .playedGames)) ?? 0
        won = (try container.decodeIfPresent(Int.self, forKey: .won)) ?? 0
        draw = (try container.decodeIfPresent(Int.self, forKey: .draw)) ?? 0
        lost = (try container.decodeIfPresent(Int.self, forKey: .lost)) ?? 0
        points = (try container.decodeIfPresent(Int.self, forKey: .points)) ?? 0
        goalsFor = (try container.decodeIfPresent(Int.self, forKey: .goalsFor)) ?? 0
        goalsAgainst = (try container.decodeIfPresent(Int.self, forKey: .goalsAgainst)) ?? 0
        goalDifference = (try container.decodeIfPresent(Int.self, forKey: .goalDifference)) ?? 0
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Team: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var crestURL: String = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int, name: String, crestURL: String) {
        super.init()
        self.id = id
        self.name = name
        self.crestURL = crestURL
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case crestURL = "crestUrl"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        name = (try container.decodeIfPresent(String.self, forKey: .name)) ?? ""
        crestURL = (try container.decodeIfPresent(String.self, forKey: .crestURL)) ?? ""
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}


class Match: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var competition: Competition? = nil
    @objc dynamic var utcDate = ""
    @objc dynamic var status = ""
    @objc dynamic var score: Score? = nil
    @objc dynamic var homeTeam: Team? = nil
    @objc dynamic var awayTeam: Team? = nil
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int, competition: Competition, utcDate: String,
         status: String, score: Score, homeTeam: Team, awayTeam: Team) {
        super.init()
        self.id = id
        self.competition = competition
        self.utcDate = utcDate
        self.score = score
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
    
    enum CodingKeys: String, CodingKey {
        case id, competition, utcDate, status, score, homeTeam, awayTeam
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        competition = try container.decodeIfPresent(Competition.self, forKey: .competition)
        utcDate = (try container.decodeIfPresent(String.self, forKey: .utcDate )) ?? ""
        score = (try container.decodeIfPresent(Score.self, forKey: .score ))
        homeTeam = (try container.decodeIfPresent(Team.self, forKey: .homeTeam ))
        awayTeam = (try container.decodeIfPresent(Team.self, forKey: .awayTeam ))
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Competition: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var code = ""
    @objc dynamic var emblemURL = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int, name: String, code: String, emblemURL: String) {
        super.init()
        self.id = id
        self.name = name
        self.code = code
        self.emblemURL = emblemURL
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, code
        case emblemURL = "emblemUrl"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        code = (try container.decodeIfPresent(String.self, forKey: .code )) ?? ""
        emblemURL = (try container.decodeIfPresent(String.self, forKey: .emblemURL )) ?? ""
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class Score: Object, Codable {
    @objc dynamic var winner = ""
    @objc dynamic var duration = ""
    @objc dynamic var fullTime: ScoreTime? = nil
    @objc dynamic var halfTime: ScoreTime? = nil
    
    init(winner: String, duration: String, fullTime: ScoreTime, halfTime: ScoreTime) {
        super.init()
        self.winner = winner
        self.duration = duration
        self.fullTime = fullTime
        self.halfTime = halfTime
    }
    
    enum CodingKeys: String, CodingKey {
        case winner, duration, fullTime, halfTime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        winner = (try container.decodeIfPresent(String.self, forKey: .winner)) ?? ""
        duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        fullTime = (try container.decodeIfPresent(ScoreTime.self, forKey: .fullTime ))
        halfTime = (try container.decodeIfPresent(ScoreTime.self, forKey: .halfTime ))
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class ScoreTime: Object, Codable {
    @objc dynamic var homeTeam = 0
    @objc dynamic var awayTeam = 0
    
    init(homeTeam: Int, awayTeam: Int) {
        super.init()
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
    
    enum CodingKeys: String, CodingKey {
        case homeTeam, awayTeam
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        homeTeam = (try container.decodeIfPresent(Int.self, forKey: .homeTeam)) ?? 0
        awayTeam = try container.decodeIfPresent(Int.self, forKey: .awayTeam) ?? 0
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
