//
//  DashboardView.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

class DashboardView: UIView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var button: UIButton?
    
    // MARK: -
    // MARK: Public

    public func configure() {
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png") ?? UIImage())
    }
    
    func flowLayoutConfigure() {
        let itemWidth = UIScreen.main.bounds.width
        let itemHeight = self.collectionView?.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight ?? 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.isPagingEnabled = true
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.button?.layer.cornerRadius = (self.button?.frame.height ?? CGFloat()) / 2
    }
}
