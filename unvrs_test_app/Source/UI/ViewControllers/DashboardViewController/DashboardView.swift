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
        self.button?.setTitle("Continue", for: .normal)
        self.button?.tintColor = .black
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png") ?? UIImage())
    }
    
    func flowLayoutConfigure() {
        let itemWidth = UIScreen.main.bounds.width - 62
        let itemHeight = self.collectionView?.frame.size.height
        let layout = PagingCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 31, bottom: 0, right: 31)
        layout.itemSize = CGSize(width: itemWidth, height: 605)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        layout.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.isPagingEnabled = false
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.button?.layer.cornerRadius = (self.button?.frame.height ?? CGFloat()) / 2
    }
}
