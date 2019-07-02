//
//  TodayFeatureCell.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import LBTATools

final class TodayFeatureCell: UITableViewCell {
    
    private(set) lazy var statusLabel = UILabel(text: nil,
                              font: .avenirBlack(ofSize: 14),
                              textColor: .darkGray,
                              textAlignment: .left,
                              numberOfLines: 0)
    
    private(set) lazy var timeLabel = UILabel(text: nil,
                            font: .avenirBlack(ofSize: 16),
                            textColor: .black,
                            textAlignment: .left,
                            numberOfLines: 0)
    
    private(set) lazy var mdLabel = UILabel(text: "MD:35",
                          font: .avenir(ofSize: 16),
                          textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
                          textAlignment: .left,
                          numberOfLines: 0)
    
    private(set) lazy var homeTeamNameLabel = UILabel(text: nil,
                                    font: .avenirBlack(ofSize: 18),
                                    textColor: .black,
                                    textAlignment: .left,
                                    numberOfLines: 0)
    
    private(set) lazy var awayTeamNameLabel = UILabel(text: nil,
                                    font: .avenirBlack(ofSize: 18),
                                    textColor: .black,
                                    textAlignment: .left,
                                    numberOfLines: 0)
    
    private(set) lazy var homeTeamScoreLabel = UILabel(text: nil,
                                     font: .avenirBlack(ofSize: 18),
                                     textColor: .black,
                                     textAlignment: .right,
                                     numberOfLines: 0)
    
    private(set) lazy var awayTeamScoreLabel = UILabel(text: nil,
                                     font: .avenirBlack(ofSize: 18),
                                     textColor: .black,
                                     textAlignment: .right,
                                     numberOfLines: 0)
    
    private(set) lazy var versusLabel = UILabel(text: "00",
                              font: .avenirBlack(ofSize: 14),
                              textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
                              textAlignment: .left,
                              numberOfLines: 0).withWidth(30)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        hstack(
            stack(statusLabel, timeLabel, mdLabel, spacing: 10).withWidth(90),
            stack(homeTeamNameLabel, awayTeamNameLabel, spacing: 10),
            stack(homeTeamScoreLabel, versusLabel, awayTeamScoreLabel).withWidth(30),
            spacing: 10
        ).withMargins(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}

extension TodayFeatureCell: ViewModelConfigurable {
    func configure(with viewModel: TodayFeatureCellViewModel) {
        statusLabel.text = viewModel.status
        timeLabel.text = viewModel.date.dateTime
        homeTeamNameLabel.text = viewModel.homeTeam
        awayTeamNameLabel.text = viewModel.awayTeam
        awayTeamScoreLabel.text = "\(viewModel.awayTeamScore ?? 0)"
        homeTeamScoreLabel.text = "\(viewModel.homeTeamScore ?? 0)"
        mdLabel.text = "MD:35"
    }
}

