//
//  PagingCollectionViewLayout.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

class PagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let pageLength:        CGFloat
        let approxPage:        CGFloat
        let nextOrCurrentPage: CGFloat
        let speed:             CGFloat
        
        if scrollDirection == .horizontal {
            pageLength = (self.itemSize.width + self.minimumLineSpacing)
            approxPage = collectionView.contentOffset.x / pageLength
            speed      = velocity.x
        } else {
            pageLength = (self.itemSize.height + self.minimumLineSpacing)
            approxPage = collectionView.contentOffset.y / pageLength
            speed      = velocity.y
        }
        
        if speed < 0 {
            nextOrCurrentPage = ceil(approxPage)
        } else if speed > 0 {
            nextOrCurrentPage = floor(approxPage)
        } else {
            nextOrCurrentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            if scrollDirection == .horizontal {
                return CGPoint(x: nextOrCurrentPage * pageLength, y: 0)
            } else {
                return CGPoint(x: 0, y: nextOrCurrentPage * pageLength)
            }
        }
        
        let nextPage: CGFloat = nextOrCurrentPage + (speed > 0 ? 1 : -1)
        
        if scrollDirection == .horizontal {
            return CGPoint(x: nextPage * pageLength, y: 0)
        } else {
            return CGPoint(x: 0, y: nextPage * pageLength)
        }
    }
}
