//
//  CompetitionDetailViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

protocol CompetitionDetailViewModelDelegate {
    func competitionDetailViewModel(_ viewModel: CompetitionDetailViewModel)
}

class CompetitionDetailViewModel {
    
    //Mark: - Public properties
    let competition: Competition
    let delegate = MulticastDelegate<CompetitionDetailViewModelDelegate>()
    
    // MARK: - Lifecycle
    init(competition: Competition) {
        self.competition = competition
    }
}
