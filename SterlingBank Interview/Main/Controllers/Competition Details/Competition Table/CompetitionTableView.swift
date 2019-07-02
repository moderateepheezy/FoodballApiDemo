//
//  CompetitionTableView.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

class CompetitionTableView: UITableView {
    // MARK: - Lifecycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    private func configure() {
        rowHeight = 50
        
        separatorStyle = .singleLine
        separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        refreshControl = UIRefreshControl()
    }
}
