//
//  CollectionViewCellViewModel.swift
//  Lotus Capital
//
//  Created by Afees Lawal on 4/14/19.
//  Copyright © 2019 SimpuMind. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewCellViewModel {
    static func register(with collectionView: UICollectionView)
    func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func selected()
}

extension CollectionViewCellViewModel {
    func selected() { }
}
