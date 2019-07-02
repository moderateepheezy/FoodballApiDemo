//
//  CollectionViewCellRepresentable.swift
//  Lotus Capital
//
//  Created by Afees Lawal on 4/14/19.
//  Copyright © 2019 SimpuMind. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewCellRepresentable: CollectionViewCellViewModel {
    associatedtype CollectionViewCell: UICollectionViewCell
}

extension CollectionViewCellRepresentable where CollectionViewCell: Reusable {
    static func register(with collectionView: UICollectionView) {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    }
    
    func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath)
    }
}

extension UICollectionView {
    func register(cells: [CollectionViewCellViewModel.Type]) {
        cells.forEach { $0.register(with: self) }
    }
}

