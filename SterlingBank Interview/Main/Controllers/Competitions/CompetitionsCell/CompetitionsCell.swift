//
//  CompetitionsCell.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import LBTATools

class CompetitionsCell: UITableViewCell {

    private(set) lazy var nameLabel = UILabel(text: nil,
                                              font: .avenirBlack(ofSize: 16),
                                              textColor: .black,
                                              textAlignment: .left,
                                              numberOfLines: 0)
    
    private lazy var imageArrow = UIImageView(image: #imageLiteral(resourceName: "forward"))
        .withSize(CGSize(width: 20, height: 15))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        hstack(nameLabel, imageArrow, spacing: 10).withMargins(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}

extension CompetitionsCell: ViewModelConfigurable {
    func configure(with viewModel: CompetitionCellViewModel) {
        nameLabel.text = viewModel.name
    }
}

