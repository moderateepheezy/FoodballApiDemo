//
//  ApplicationCoordinator.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator {
    
    //MARK: - Private Properties
    fileprivate let navigationController: UINavigationController
    
    let tabController: UITabBarController
    
    var fixtureNavigation: UINavigationController
    var competitionNavigation: UINavigationController
    
    //MARK: - Private Functions
    fileprivate func setupNavController(nav: UINavigationController) {
        nav.navigationBar.isTranslucent = false
        nav.isNavigationBarHidden = true
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        
        nav.navigationBar.tintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
        
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)]
    }
    
    //MARK: - Lifecycle
    init(rootNavigationController: UINavigationController) {
        
        self.navigationController = rootNavigationController
        self.tabController = UITabBarController()
        self.fixtureNavigation = UINavigationController()
        self.competitionNavigation = UINavigationController()
        competitionNavigation.navigationBar.isTranslucent = false
        
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = ""
        barButtonItem.tintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
        
        setupNavController(nav: navigationController)
    }
    
    // MARK: - Public
    func start() {
        showHome()
        UIBarButtonItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
}

// MARK: - Error Handling
private extension ApplicationCoordinator {
    func handle(error: String) {
        let alert = UIAlertController(
            title: "Error",
            message: error,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        
        let target = navigationController.visibleViewController ?? navigationController
        target.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Routing
extension ApplicationCoordinator {
    
    func showHome() {
        var controllers: [UIViewController] = []
        
        let viewModel = TodayFixtureViewModel()
        viewModel.delegate.add(self)
        let todayFixtureViewController = TodayFixturesViewController(viewModel: viewModel)
        todayFixtureViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "ball"), tag: 0)
        fixtureNavigation.viewControllers = [todayFixtureViewController]
        
        let competitonViewModel = CompetitionsViewModel()
        competitonViewModel.delegate.add(self)
        let competitonViewController = CompetitionsViewController(viewModel: competitonViewModel)
        competitionNavigation.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "pitch"), tag: 1)
        competitionNavigation.viewControllers = [competitonViewController]
        
        controllers.append(fixtureNavigation)
        controllers.append(competitionNavigation)
        
        tabController.viewControllers = controllers
        //tabController.tabBar.isTranslucent = false
        //tabController.delegate = self
        
        self.navigationController.setViewControllers([tabController], animated: true)
        
        
    }
    
    func showCompetitionsDetails(competition: Competition) {
        let viewModel = CompetitionDetailViewModel(competition: competition)
        viewModel.delegate.add(self)
        let viewController = CompetionDetailViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        self.competitionNavigation.pushViewController(viewController, animated: true)
    }
}


// MARK: - TodayFixtureViewModel Delegate
extension ApplicationCoordinator: TodayFixtureViewModelDelegate {
    func todayFixtureViewModelUpdated(_ viewModel: TodayFixtureViewModel) {}
    
    func todayFixtureViewModel(_ viewModel: TodayFixtureViewModel) {}
    
    func todayFixtureViewModel(_ viewModel: TodayFixtureViewModel, error: String) {
        handle(error: error)
    }
}

// MARK: - CompetitionsViewModelDelegate Delegate
extension ApplicationCoordinator: CompetitionsViewModelDelegate {
    func competitionsViewModel(_ viewModel: CompetitionsViewModel, didSelect competition: Competition) {
        showCompetitionsDetails(competition: competition)
    }
    
    func competitionsViewModelUpdate(_ viewModel: CompetitionsViewModel) {}
    
    func competitionsViewModel(_ viewModel: CompetitionsViewModel, error: String) {
        handle(error: error)
    }
}

extension ApplicationCoordinator: CompetitionDetailViewModelDelegate {
    func competitionDetailViewModel(_ viewModel: CompetitionDetailViewModel) {
    }
}

extension ApplicationCoordinator: CompetitionTableViewDelegate {
    func competitionTableViewModelUpdated(_ viewModel: CompetitionTableViewModel) {}
    
    func competitionTableViewModel(_ viewModel: CompetitionTableViewModel) {}
    
    func competitionTableViewModel(_ viewModel: CompetitionTableViewModel, error: String) {
        handle(error: error)
    }
    
    
}


