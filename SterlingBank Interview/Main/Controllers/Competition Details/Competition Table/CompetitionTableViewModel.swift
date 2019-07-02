//
//  CompetitionTableViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

protocol CompetitionTableViewDelegate {
    func competitionTableViewModelUpdated(_ viewModel: CompetitionTableViewModel)
    func competitionTableViewModel(_ viewModel: CompetitionTableViewModel)
    func competitionTableViewModel(_ viewModel: CompetitionTableViewModel, error: String)
}

class CompetitionTableViewModel {
    
    // MARK: - Private Properties
    private var working = false
    private let code: String
    
    // MARK: - Public Properties
    let name: String
    let delegate = MulticastDelegate<CompetitionTableViewDelegate>()
    let cells: [TableViewCellViewModel.Type] = [CompetitionTableCellViewModel.self]
    fileprivate(set) var dataSet: [TableViewCellViewModel] = [] {
        didSet {
            delegate.notify { $0.competitionTableViewModelUpdated(self) }
        }
    }
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
        let standingEntities = DatabaseManager<StandingEntity>.findBy(key: "code", value: code as AnyObject)
        if standingEntities.count > 0 {
            let standingEntity = standingEntities[0]
            let tables = standingEntity.standingArray.filter {$0.type == "TOTAL"}.map {$0.tables}
            self.dataSet = tables.count == 0 ? [] : tables[0]
                .enumerated()
                .map {CompetitionTableCellViewModel(table: $0.element, index: "\($0.offset + 1)")}
        }
    }
    
    // MARK: - Public Functions
    func reloadData() {
        guard !working else { return }
        
        working = true
        let request = NetworkManager()
        
        request.fetchCompetitionStanding(id: code) {[weak self] (tables, message) in
            guard let self = self  else {return}
            if let tables = tables {
                self.dataSet = tables
                    .enumerated()
                    .map {CompetitionTableCellViewModel(table: $0.element, index: "\($0.offset + 1)")}
            } else {
                self.delegate.notify {$0.competitionTableViewModel(self, error: message)}
            }
            self.working = false
        }
    }
    
    func didSelect(at index: Int) {
//        guard let data = dataSet[index] as? CompetitionCellViewModel
//            else {return}
//        self.delegate.notify { $0.competitionsViewModel(self, didSelect: data.competition)}
    }
    
}
