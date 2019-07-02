//
//  TodayFeatureCellModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation


final class TodayFeatureCellViewModel {
    
    // MARK: - Private Properties
    private let match: Match
    
    // MARK: - Public Properties
    var status: String? { return match.status }
    var date: String { return match.utcDate }
    var homeTeam: String? { return match.homeTeam?.name }
    var awayTeam: String? { return match.awayTeam?.name }
    var homeTeamScore: Int? { return match.score?.fullTime?.homeTeam }
    var awayTeamScore: Int? { return match.score?.fullTime?.awayTeam }
    
    // MARK: - Lifecycle
    init(match: Match) {
        self.match = match
    }
}

extension TodayFeatureCellViewModel: TableViewCellRepresentable {
    typealias TableViewCell = TodayFeatureCell
}
