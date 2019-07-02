//
//  TodayFixtureViewModel.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

protocol TodayFixtureViewModelDelegate: class {
    func todayFixtureViewModelUpdated(_ viewModel: TodayFixtureViewModel)
    func todayFixtureViewModel(_ viewModel: TodayFixtureViewModel)
    func todayFixtureViewModel(_ viewModel: TodayFixtureViewModel, error: String)
}

final class TodayFixtureViewModel {
    
    // MARK: - Private Properties
    private var working = false
    private var id: String?
    
    // MARK: - Public Properties
    let delegate = MulticastDelegate<TodayFixtureViewModelDelegate>()
    let cells: [TableViewCellViewModel.Type] = [TodayFeatureCellViewModel.self]
    fileprivate(set) var dataSet: [TableViewCellViewModel] = [] {
        didSet {
            delegate.notify { $0.todayFixtureViewModelUpdated(self) }
        }
    }
    
    init() {
        let match_es = DatabaseManager<Match>.findAll()
        self.dataSet = match_es.map(TodayFeatureCellViewModel.init)
    }
    
    //MARK: - Lifecycle
    init(id: String) {
        self.id = id
        
        let fixtureEntities = DatabaseManager<FixtureResponse>.findBy(key: "code", value: id as AnyObject)
        if fixtureEntities.count > 0 {
            self.dataSet = fixtureEntities[0].matchList.map (TodayFeatureCellViewModel.init)
        }
    }
    
    // MARK: - Public Functions
    func reloadData() {
        guard !working else { return }
        
        working = true
        let request = NetworkManager()
        
        if let id = id {
         
            request.fetchCompetitionFixtures(id: id) {[weak self] (matches, message) in
                guard let self = self else { return }
                if let matches = matches {
                    self.dataSet = matches.map(TodayFeatureCellViewModel.init)
                } else {
                    self.delegate.notify { $0.todayFixtureViewModel(self, error: message) }
                }
                self.working = false
            }
            
            return
        }
        
        request.fetchTodayFixtures {[weak self] (matches, message) in
            guard let self = self else { return }
            if let matches = matches {
                self.dataSet =  matches.map(TodayFeatureCellViewModel.init)
            } else {
                self.delegate.notify { $0.todayFixtureViewModel(self, error: message) }
            }
            self.working = false
        }
    }
    
    func didSelect(at index: Int) {
        self.delegate.notify { $0.todayFixtureViewModel(self) }
    }
}
