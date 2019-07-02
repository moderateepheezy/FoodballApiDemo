//
//  CompetitionTeamCell.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/28/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder
import LBTATools

class CompetitionTeamCell: UICollectionViewCell {
    
    let containerView = UIView(backgroundColor: .white)
    
    let clubImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
    let clubNameLabel = UILabel(text: nil,
                                font: .avenirBlack(ofSize: 16),
                                textColor: .darkGray,
                                textAlignment: .center,
                                numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 8.0
        containerView.layer.shadowOpacity = 0.7
        clubImageView.clipsToBounds = true
        clubImageView.withWidth(80)
        clubImageView.withHeight(80)
        stack(containerView)
            .padTop(10)
            .padLeft(8)
            .padRight(8)
        containerView.stack(clubImageView, clubNameLabel, spacing: 10).withMargins(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            .alignment = .center
    }
}

extension CompetitionTeamCell: CollectionViewViewModelConfigurable {
    func configure(with viewModel: CompetitionTeamsCellViewModel) {
        clubNameLabel.text = viewModel.name
        
        if let urlString = viewModel.teamImageUrl, let url = URL(string: urlString) {
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            let SVGImageSize = CGSize(width: 20, height: 20)
            clubImageView
                .sd_setImage(with: url,
                             placeholderImage: nil,
                             options: [],
                             context: [.svgImageSize : SVGImageSize])
        }
    }
}
