//
//  CompetionDetailViewController.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

class CompetionDetailViewController: CustomViewController<CompetitionDetailView, CompetitionDetailViewModel> {

    //MARK:- Private Properties
    
    //Enum to hold index of each segment controller
    private enum TabIndex: Int {
        case tableChildTab = 0
        case fixturesChildTab = 1
        case teamChildTab = 2
    }
    
    //The current visible controller
    private var currentViewController: UIViewController?
    
    // Table ViewController
    private lazy var competitionTableViewController: CompetitionTableViewController? = {
        let viewModel = CompetitionTableViewModel(code: "\(self.viewModel.competition.id)", name: self.viewModel.competition.name)
        let viewController = CompetitionTableViewController()
        viewController.viewModel = viewModel
        return viewController
    }()
    
    // Fixture ViewController
    private lazy var fixtureController: TodayFixturesViewController? = {
        let viewModel = TodayFixtureViewModel(id: "\(self.viewModel.competition.code )")
        let viewController = TodayFixturesViewController(viewModel: viewModel)
        return viewController
    }()
    
    // Team ViewController
    private lazy var teamController: CompetitionTeamViewController? = {
        let viewModel = CompetitionTeamViewModel(id: "\(self.viewModel.competition.code )")
        let viewController = CompetitionTeamViewController(viewModel: viewModel)
        return viewController
    }()
    
    // MARK: - Lifecycle
    required init(viewModel: CompetitionDetailViewModel) {
        super.init(viewModel: viewModel)
        title = viewModel.competition.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentTab(TabIndex.tableChildTab.rawValue)
        customView.segmentedControl.addTarget(self, action: #selector(switchTabs(_:)), for: .valueChanged)
    }
    
    // MARK: - Switching Tabs Functions
    @objc private func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int) {
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = customView.contentView.bounds
            customView.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.tableChildTab.rawValue :
            vc = competitionTableViewController
        case TabIndex.fixturesChildTab.rawValue :
            vc = fixtureController
        case TabIndex.teamChildTab.rawValue :
            vc = teamController
        default:
            return nil
        }
        return vc
    }
}
