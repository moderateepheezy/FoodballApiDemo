//
//  CompetitionTeamView.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

class CompetitionTeamView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        refreshControl = UIRefreshControl()
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        refreshControl = UIRefreshControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
