//
//  CompetitionTeamViewController.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CompetitionTeamViewController: CustomViewController<CompetitionTeamView, CompetitionTeamViewModel>, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        customView.register(cells: viewModel.cells)
        customView.dataSource = self
        customView.delegate = self
        customView.emptyDataSetSource = self
        customView.emptyDataSetDelegate = self
        
        viewModel.delegate.add(self)
        customView.refreshControl?.beginRefreshing()
        viewModel.reloadData()
    }
    
    deinit {
        viewModel.delegate.remove(self)
    }
    
    // MARK: - Actions
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.reloadData()
    }
    
    // MARK: - Empty TableView Delegate and Datasource
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Teams"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = ""
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return #imageLiteral(resourceName: "ball")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        let str = "Retry"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        customView.refreshControl?.beginRefreshing()
        viewModel.reloadData()
    }
}

extension CompetitionTeamViewController: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(viewModel.dataSet[indexPath.row])
        return viewModel.dataSet[indexPath.row].dequeue(from: collectionView, at: indexPath)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (customView.frame.width  / 2) - 6, height: 185)
    }
}

extension CompetitionTeamViewController: CompetitionTeamViewModelDelegate {
    func competitionTeamViewModel(_ viewModel: CompetitionTeamViewModel) {
        customView.refreshControl?.endRefreshing()
    }
    
    func competitionTeamViewModelUpdate(_ viewModel: CompetitionTeamViewModel) {
        customView.refreshControl?.endRefreshing()
        customView.reloadData()
    }
    
    func competitionTeamViewModel(_ viewModel: CompetitionTeamViewModel, error: String) {
        customView.refreshControl?.endRefreshing()
    }
    
    
}
