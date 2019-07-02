//
//  CompetitionTableCell.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/27/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder

class CompetitionTableCell: UITableViewCell {

    private(set) lazy var indexLabel = UILabel(text: nil,
                                               font: .avenirBlack(ofSize: 13),
                                               textColor: .black,
                                               textAlignment: .left,
                                               numberOfLines: 0)
    
    private(set) lazy var clubImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    
    private(set) lazy var clubNameLabel = UILabel(text: nil,
                                               font: .avenirBlack(ofSize: 15),
                                               textColor: .black,
                                               textAlignment: .left,
                                               numberOfLines: 0)
    
    private(set) lazy var numberOfGamesLabel = UILabel(text: nil,
                                               font: .avenirBook(ofSize: 14),
                                               textColor: .black,
                                               textAlignment: .left,
                                               numberOfLines: 0)
    
    private(set) lazy var numberOfGoalsLabel = UILabel(text: nil,
                                                       font: .avenirBook(ofSize: 14),
                                                       textColor: .black,
                                                       textAlignment: .left,
                                                       numberOfLines: 0)
    
    private(set) lazy var numberOfPointsLabel = UILabel(text: nil,
                                                       font: .avenirBook(ofSize: 14),
                                                       textColor: .black,
                                                       textAlignment: .left,
                                                       numberOfLines: 0)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    
    private func configure() {
        indexLabel.withWidth(20)
        clubImageView.withWidth(20)
        numberOfGamesLabel.withWidth(20)
        numberOfGoalsLabel.withWidth(20)
        numberOfPointsLabel.withWidth(20)
        hstack(
            hstack(indexLabel, clubImageView, clubNameLabel, spacing: 10), hstack(numberOfGamesLabel, numberOfGoalsLabel, numberOfPointsLabel, spacing: 10).withWidth(100)
        )
    }

}

extension CompetitionTableCell: ViewModelConfigurable {
    func configure(with viewModel: CompetitionTableCellViewModel) {
        indexLabel.text = viewModel.index
        clubNameLabel.text = viewModel.clubName
        numberOfGoalsLabel.text = viewModel.totalGoals
        numberOfGamesLabel.text = viewModel.totalGamesPlayed
        numberOfPointsLabel.text = viewModel.totalPoints
        
        if let url = URL(string: viewModel.imageUrl) {
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            let SVGImageSize = CGSize(width: 20, height: 20)
            clubImageView.sd_setImage(with: url, placeholderImage: nil, options: [], context: [.svgImageSize : SVGImageSize])
        }
        
    }
}
