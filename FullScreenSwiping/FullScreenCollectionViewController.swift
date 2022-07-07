//
//  FullPageCollectionViewController.swift
//  u1v1Me
//
//  Created by Q on 2022-06-30.
//  Copyright © 2022 1v1MeApp. All rights reserved.
//

import Foundation
import UIKit

class FullPageCollectionViewController: UIViewController {
    let layout = FullPageCollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.decelerationRate = .fast
        return collectionView
    }()

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        layout.indexPathForCellInFrameBeforeBoundsChange = collectionView.lastVisibleIndexInFrame
    }
    
    override func loadView() {
        view = collectionView
    }
}
