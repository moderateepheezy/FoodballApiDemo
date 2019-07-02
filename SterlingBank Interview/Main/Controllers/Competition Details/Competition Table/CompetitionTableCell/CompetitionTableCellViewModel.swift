//
//  CompetitionTableCellViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

final class CompetitionTableCellViewModel {
    
    //MARK: - Public Properties
    let table: Table
    let index: String
    
    var imageUrl: String { return table.team?.crestURL ?? "" }
    var clubName: String { return table.team?.name ?? ""}
    var totalGamesPlayed: String { return "\(table.playedGames )" }
    var totalGoals: String { return "\(table.goalsFor )" }
    var totalPoints: String { return "\(table.points )" }
    
    //MARK: - Lifecycle
    init(table: Table, index: String) {
        self.table = table
        self.index = index
    }
}

extension CompetitionTableCellViewModel: TableViewCellRepresentable {
    typealias TableViewCell = CompetitionTableCell
}
