//
//  Pager View.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 11.06.2023.
//

import UIKit

protocol ScrollToPageProtocol {
    
    func scrollTo(page: IndexPath)
}

class PagerView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: -
    // MARK: Variables
    
    var numberOfPages: Int = 4
    var actualPage: Int = 0
    var arrayOfViews: [UIView] = []
    var scrollDelegate: ScrollToPageProtocol?
    let containerHeight = 4
    let disabledContainerWidth = 14
    let enabledContainerWidth = 25
    let spacingBetweenCells = 8
    let layout = UICollectionViewFlowLayout()
    
    // MARK: -
    // MARK: Init

    init() {
        super.init(frame: CGRect(), collectionViewLayout: layout)
        
        self.registerDefaultCell(cellClass: UICollectionViewCell.self)
        self.dataSource = self
        self.delegate = self
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.registerDefaultCell(cellClass: UICollectionViewCell.self)
        self.dataSource = self
        self.delegate = self
        self.collectionViewLayout = self.layout
        self.setup()
    }
    
    // MARK: -
    // MARK: Public
    
    func updateViews(number: Int) {
        if number >= 0 && number < self.numberOfPages {
            self.actualPage = number
            arrayOfViews.forEach {
                $0.subviews.first?.backgroundColor = UIColor(named: "PagerGray")
                $0.frame.size.width = CGFloat(self.disabledContainerWidth)
                $0.subviews.first?.frame.size.width = CGFloat(self.disabledContainerWidth)
            }
            self.arrayOfViews[number].subviews.first?.backgroundColor = UIColor(named: "PagerBlue")
            self.arrayOfViews[number].frame.size.width = CGFloat(self.enabledContainerWidth)
            self.arrayOfViews[number].subviews.first?.frame.size.width = CGFloat(self.enabledContainerWidth)
            self.reloadData()
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func setup() {
        self.prepareViews()
    }
    
    private func prepareLayout() {
        self.layout.scrollDirection = .horizontal
        self.layout.sectionInset = self.prepareInsets()
        self.isScrollEnabled = false
    }
    
    private func prepareViews() {
        for _ in 0...self.numberOfPages {
            let view = UIView()
            view.layer.cornerRadius = CGFloat(self.containerHeight / 2)
            let viewContainer = UIView()
            viewContainer.frame.size = CGSize(width: self.disabledContainerWidth, height: self.containerHeight)
            viewContainer.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            self.prepareConstraints(subView: view, superView: viewContainer, xInset: 0, yInset: 0)
            
            self.arrayOfViews.append(viewContainer)
        }
        self.updateViews(number: self.actualPage)
    }
    
    private func prepareConstraints(subView: UIView, superView: UIView, xInset: CGFloat, yInset: CGFloat) {
        NSLayoutConstraint.activate([
            subView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -xInset),
            subView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: xInset),
            subView.topAnchor.constraint(equalTo: superView.topAnchor, constant: yInset),
            subView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -yInset)
        ])
    }
    
    private func prepareInsets() -> UIEdgeInsets {
        let totalCellWidth = ((self.disabledContainerWidth) * (self.numberOfPages - 1)) + self.enabledContainerWidth + (self.spacingBetweenCells * (numberOfPages - 1))
        
        let horizontalInset = (self.bounds.width - CGFloat(totalCellWidth)) / 2
        let verticalInset = (self.bounds.height - CGFloat(self.containerHeight)) / 2

        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.prepareLayout()
    }

    // MARK: -
    // MARK: UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(cellClass: UICollectionViewCell.self, indexPath: indexPath)
        let view = self.arrayOfViews[indexPath.row]
        cell.addSubview(view)
 
        return cell
    }

    // MARK: -
    // MARK: UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollDelegate?.scrollTo(page: indexPath)
    }
    
    // MARK: -
    // MARK: UICollectionViewFlowLayout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == self.actualPage {
            return CGSize(width: self.enabledContainerWidth, height: self.containerHeight)
        } else {
            return CGSize(width: self.disabledContainerWidth, height: self.containerHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(self.spacingBetweenCells)
    }
}
