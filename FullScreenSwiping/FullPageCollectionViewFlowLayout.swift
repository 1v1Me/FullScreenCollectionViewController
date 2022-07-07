//
//  FullPageCollectionViewFlowLayout.swift
//  FullScreenSwiping
//
//  Created by Q on 2022-07-07.
//

import UIKit

class FullPageCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var preRotationFirstIndexPath: IndexPath?
    var indexPathForCellInFrameBeforeBoundsChange: IndexPath?
    
    override init() {
        super.init()
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Will begin rotation of collection view
    override func prepare(forAnimatedBoundsChange oldBounds: CGRect) {
        super.prepare(forAnimatedBoundsChange: oldBounds)
        preRotationFirstIndexPath = collectionView?.indexPathsForVisibleItems.first
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard
            let indexPath = preRotationFirstIndexPath,
            let attributes = layoutAttributesForItem(at: indexPath),
            let collectionView = collectionView
        else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        return CGPoint(
            x: attributes.frame.origin.x - collectionView.contentInset.left,
            y: attributes.frame.origin.y - collectionView.contentInset.top
        )
    }

    // Did finish rotation & layout of collection view
    override func finalizeAnimatedBoundsChange() {
        super.finalizeAnimatedBoundsChange()
        if let indexPath = indexPathForCellInFrameBeforeBoundsChange, indexPath != collectionView?.lastVisibleIndexInFrame {
            collectionView?.scrollToItem(at: indexPath, at: .top, animated: false)
        }
        preRotationFirstIndexPath = nil
    }

    // https://stackoverflow.com/a/47032532
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // If there is a preRotationFirstIndexPath it indicates that we are mid rotation and
        // we should not be customizing the targetContentOffset.
        guard preRotationFirstIndexPath == nil, let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        // Page height used for estimating and calculating paging.
        let pageHeight = self.itemSize.height + self.minimumLineSpacing

        // Make an estimation of the current page position.
        let approximatePage = collectionView.contentOffset.y / pageHeight

        // Determine the current page based on velocity.
        let currentPage = velocity.y == 0 ? round(approximatePage) : (velocity.y < 0.0 ? floor(approximatePage) : ceil(approximatePage))

        // Create custom flickVelocity.
        let flickVelocity = velocity.y * 0.1

        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

        let newVerticalOffset = ((currentPage + flickedPages) * pageHeight) - collectionView.contentInset.top

        return CGPoint(x: proposedContentOffset.x, y: newVerticalOffset)
    }

    override var itemSize: CGSize {
        get { collectionView?.frame.size ?? .zero }
        set { }
    }
}
