//
//  CompetitionTeamViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/28/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

protocol CompetitionTeamViewModelDelegate {
    func competitionTeamViewModel(_ viewModel: CompetitionTeamViewModel)
    func competitionTeamViewModelUpdate(_ viewModel: CompetitionTeamViewModel)
    func competitionTeamViewModel(_ viewModel: CompetitionTeamViewModel, error: String)
}
class CompetitionTeamViewModel {
    
    // MARK: - Private Properties
    private var working = false
    private var id: String
    
    // MARK: - Public Properties
    let delegate = MulticastDelegate<CompetitionTeamViewModelDelegate>()
    let cells: [CollectionViewCellViewModel.Type] = [CompetitionTeamsCellViewModel.self]
    fileprivate(set) var dataSet: [CollectionViewCellViewModel] = [] {
        didSet {
            delegate.notify { $0.competitionTeamViewModelUpdate(self) }
        }
    }
    
    //MARK: - Lifecycle
    init(id: String) {
        self.id = id
        
        let teamEntities = DatabaseManager<TeamEntity>.findBy(key: "code", value: id as AnyObject)
        if teamEntities.count > 0 {
            let teamEntity = teamEntities[0]
            self.dataSet = teamEntity.teamArray.map (CompetitionTeamsCellViewModel.init)
        }
    }
    
    // MARK: - Public Functions
    func reloadData() {
        guard !working else { return }
        
        working = true
        let request = NetworkManager()
        
        request.fetchCompetitionTeams(id: id) {[weak self] (teams, message) in
            guard let self = self  else {return}
            if let teams = teams {
                self.dataSet = teams
                    .map (CompetitionTeamsCellViewModel.init)
            } else {
                self.delegate.notify { $0.competitionTeamViewModel(self, error: message) }
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
