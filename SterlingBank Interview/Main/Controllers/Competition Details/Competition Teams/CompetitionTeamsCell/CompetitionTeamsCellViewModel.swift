//
//  CompetitionTeamsCellViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/28/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

final class CompetitionTeamsCellViewModel {
    
    //MARK: - Private Properties
    private let team: Team
    
    //MARK: - Public Properties
    var id: String { return "\(team.id )" }
    var name: String? { return team.name }
    var teamImageUrl: String? { return team.crestURL }
    
    // MARK: - Lifecycle
    init(team: Team) {
        self.team = team
    }
}

extension CompetitionTeamsCellViewModel: CollectionViewCellRepresentable {
    typealias CollectionViewCell = CompetitionTeamCell
}
