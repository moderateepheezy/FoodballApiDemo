//
//  CompetitionCellViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

final class CompetitionCellViewModel {
    
    // MARK: - Private Properties
    let competition: Competition
    
    // MARK: - Public Properties
    var name: String? { return competition.name }
    var code: String? { return competition.code }
    var id: Int { return competition.id }
    
    // MARK: - Lifecycle
    init(competition: Competition) {
        self.competition = competition
    }
}

extension CompetitionCellViewModel: TableViewCellRepresentable {
    typealias TableViewCell = CompetitionsCell
}

