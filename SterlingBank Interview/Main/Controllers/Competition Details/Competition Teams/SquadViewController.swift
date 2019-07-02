//
//  SquadViewController.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 7/1/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder
import LBTATools

class HeaderView: UICollectionReusableView {
    let clubImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    var imageUrl: String? {
        didSet {
            if let urlString = imageUrl, let url = URL(string: urlString) {
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        clubImageView.clipsToBounds = true
        stack(clubImageView).withWidth(80).withHeight(80)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SquadDetailCell: LBTAListCell<Squad> {
    
    let indexLabel = UILabel(text: nil,
                             font: .avenirBook(ofSize: 14),
                             textColor: .black,
                             textAlignment: .left,
                             numberOfLines: 0)
    
    let nameLabel = UILabel(text: nil,
                            font: .avenirBook(ofSize: 14),
                            textColor: .black,
                            textAlignment: .right,
                            numberOfLines: 0)
    
    let positionLabel = UILabel(text: nil,
                                font: .avenirBook(ofSize: 14),
                                textColor: .black,
                                textAlignment: .left,
                                numberOfLines: 0)
    
    
    override var item: Squad! {
        didSet {
            indexLabel.text = item.role
            positionLabel.text = item.position
            nameLabel.text = item.name
        }
    }
    
    var index: Int? {
        didSet {
            indexLabel.text = "\(index ?? 0)"
        }
    }
    
    override func setupViews() {
        super.setupViews()
        hstack(
            stack(indexLabel, nameLabel, spacing: 15),
            stack(positionLabel).withWidth(100),
            spacing: 15
        )
        addSeparatorView()
    }
}

class SquadViewController: LBTAListHeaderController<SquadDetailCell, Squad, HeaderView> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SquadViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}
