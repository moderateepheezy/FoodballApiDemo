//
//  CompetitionsViewController.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CompetitionsViewController: CustomViewController<CompetitionsView, CompetitionsViewModel>,
UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    required init(viewModel: CompetitionsViewModel) {
        super.init(viewModel: viewModel)
        title = "Competitions"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelect(at: indexPath.item)
    }
    
    // MARK: - Actions
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.reloadData()
    }
    
    // MARK: - Empty TableView Delegate and Datasource
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Competitions"
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

extension CompetitionsViewController: CompetitionsViewModelDelegate {
    func competitionsViewModel(_ viewModel: CompetitionsViewModel, didSelect competition: Competition) {}
    
    func competitionsViewModelUpdate(_ viewModel: CompetitionsViewModel) {
        customView.reloadData()
        customView.refreshControl?.endRefreshing()
    }
    
    func competitionsViewModel(_ viewModel: CompetitionsViewModel, error: String) {
        customView.refreshControl?.endRefreshing()
    }
    
    
}
