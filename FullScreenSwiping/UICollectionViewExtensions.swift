//
//  UICollectionViewExtensions.swift
//  FullScreenSwiping
//
//  Created by Q on 2022-07-07.
//

import UIKit

extension UICollectionView {
    var lastVisibleIndexInFrame: IndexPath? {
        var visibleIndexPath: IndexPath?
        indexPathsForVisibleItems.forEach { indexPath in
            guard let cell = cellForItem(at: indexPath) else { return }
            if bounds.contains(cell.frame) {
                visibleIndexPath = indexPath
            }
        }
        return visibleIndexPath
    }
}
