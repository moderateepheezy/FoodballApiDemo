//
//  CompetitionsViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

protocol CompetitionsViewModelDelegate {
    func competitionsViewModelUpdate(_ viewModel: CompetitionsViewModel)
    func competitionsViewModel(_ viewModel: CompetitionsViewModel, error: String)
    func competitionsViewModel(_ viewModel: CompetitionsViewModel, didSelect competition: Competition)
}

final class CompetitionsViewModel {
    
    // MARK: - Private Properties
    private var working = false
    
    // MARK: - Public Properties
    let delegate = MulticastDelegate<CompetitionsViewModelDelegate>()
    let cells: [TableViewCellViewModel.Type] = [CompetitionCellViewModel.self]
    fileprivate(set) var dataSet: [TableViewCellViewModel] = [] {
        didSet {
            delegate.notify { $0.competitionsViewModelUpdate(self) }
        }
    }
    
    init() {
        let match_es = DatabaseManager<Competition>.findAll()
        self.dataSet = match_es.map(CompetitionCellViewModel.init)
    }
    
    // MARK: - Public Functions
    func reloadData() {
        guard !working else { return }
        
        working = true
        let request = NetworkManager()
        
        request.fetchCompetitions {[weak self] (competitions, message) in
            guard let self = self  else {return}
            if let competitions = competitions {
                self.dataSet = competitions
                    .filter{ $0.code != "" }
                    .map(CompetitionCellViewModel.init)
            } else {
                self.delegate.notify {$0.competitionsViewModel(self, error: message)}
            }
            self.working = false
        }
    }
    
    func didSelect(at index: Int) {
        guard let data = dataSet[index] as? CompetitionCellViewModel
            else {return}
        self.delegate.notify { $0.competitionsViewModel(self, didSelect: data.competition)}
    }
}
