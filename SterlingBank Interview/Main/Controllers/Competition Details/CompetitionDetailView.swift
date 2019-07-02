//
//  CompetitionDetailView.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import LBTATools

final class CompetitionDetailView: BaseView {
    
    private(set) lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Table", "Fixtures", "Teams"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setDividerImage(nil, forLeftSegmentState: UIControl.State(), rightSegmentState: UIControl.State(), barMetrics: .default)
        
        let selectedTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.avenirBlack(ofSize: 14)!
        ]
        
        let normalTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.avenirBlack(ofSize: 14)!
        ]

        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .highlighted)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        return segmentedControl
    }()
    
    private(set) lazy var contentView = UIView(backgroundColor: .white)
    
    override func configure() {
        segmentedControl.withHeight(40)
        stack(segmentedControl, contentView, spacing: 2).withMargins(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
}
