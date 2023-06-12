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
    @IBOutlet var pager: PagerView?
    
    // MARK: -
    // MARK: Variables
    
    let cellHorizontalInsets: CGFloat = 31
    let spacingBetweenCells: CGFloat = 16
    
    // MARK: -
    // MARK: Public

    public func configure() {
        self.button?.setTitle("Continue", for: .normal)
        self.button?.tintColor = .black
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png") ?? UIImage())
    }
    
    public func configurePager() {
        let offsetStep = self.frame.width - (self.cellHorizontalInsets * 2) + self.spacingBetweenCells
        let xPosition = (self.collectionView?.contentOffset.x ?? 0) + offsetStep
        let dividend = (xPosition / offsetStep)
        if !(dividend.isNaN || dividend.isInfinite) {
            let rounded = Int(round(dividend))
            let index = rounded - 1
            self.pager?.updateViews(number: index)
        }
    }
    
    func flowLayoutConfigure() {
        let itemWidth = UIScreen.main.bounds.width - (self.cellHorizontalInsets * 2)
        let itemHeight = self.collectionView?.frame.size.height
        let layout = PagingCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: self.cellHorizontalInsets,
            bottom: 0,
            right: self.cellHorizontalInsets
        )
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight ?? 0)
        layout.minimumLineSpacing = self.spacingBetweenCells
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
