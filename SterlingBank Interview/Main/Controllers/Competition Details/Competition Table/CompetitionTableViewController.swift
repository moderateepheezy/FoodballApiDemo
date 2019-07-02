//
//  CompetitionTableViewController.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CompetitionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    let customView = CompetitionTableView()
    var viewModel: CompetitionTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)
        customView.fill(view)
        title = viewModel.name
        customView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        customView.register(cells: viewModel.cells)
        customView.dataSource = self
        customView.delegate = self
        customView.emptyDataSetSource = self
        customView.emptyDataSetDelegate = self
        customView.tableFooterView = UIView()
        
        viewModel.delegate.add(self)
        customView.refreshControl?.beginRefreshing()
        viewModel.reloadData()
    }
    
    deinit {
        viewModel.delegate.remove(self)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.dataSet[indexPath.row].dequeue(from: tableView, at: indexPath)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath.item)
    }
    
    // MARK: - Actions
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.reloadData()
    }
    
    // MARK: - Empty TableView Delegate and Datasource
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Standings Available"
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

extension CompetitionTableViewController: CompetitionTableViewDelegate {
    func competitionTableViewModelUpdated(_ viewModel: CompetitionTableViewModel) {
        customView.refreshControl?.endRefreshing()
        customView.reloadData()
    }
    
    func competitionTableViewModel(_ viewModel: CompetitionTableViewModel) {
        customView.refreshControl?.endRefreshing()
    }
    
    func competitionTableViewModel(_ viewModel: CompetitionTableViewModel, error: String) {
        customView.refreshControl?.endRefreshing()
    }
    
    
}
