//
//  Pager View.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 11.06.2023.
//

protocol ScrollToPageProtocol {
    
    func scrollTo(page: IndexPath)
}

import UIKit

class PagerView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: -
    // MARK: Variables
    
    var numberOfPages: Int = 4
    var arrayOfViews: [UIView] = []
    var scrollDelegate: ScrollToPageProtocol?
    let containerHeight = 8
    let containerWidth = 14
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
        arrayOfViews.forEach {
            $0.subviews.first?.backgroundColor = UIColor(named: "PagerGrey")
        }
        self.arrayOfViews[number].subviews.first?.backgroundColor = UIColor(named: "PagerBlue")
    }
    
    // MARK: -
    // MARK: Private
    
    private func setup() {
        self.prepareViews()
    }
    
    private func prepareLayout() {
        self.layout.scrollDirection = .horizontal
        self.layout.sectionInset = self.getInsets()
        self.layout.itemSize = CGSize(width: self.containerWidth * 2, height: self.containerHeight)
        self.layout.minimumLineSpacing = 0
        self.isScrollEnabled = false
    }
    
    private func prepareViews() {
        for _ in 0...self.numberOfPages {
            let view = UIView()
            view.frame.size = CGSize(width: self.containerWidth / 2, height: self.containerHeight / 2)
            view.layer.cornerRadius = CGFloat(self.containerHeight / 4)
            view.backgroundColor = .white
            
            let viewContainer = UIView()
            viewContainer.frame.size = CGSize(width: self.containerWidth * 2, height: self.containerHeight)
            viewContainer.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            let containerInset = CGFloat(self.containerHeight / 4)
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -containerInset),
                view.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: containerInset),
                view.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: containerInset),
                view.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -containerInset)
            ])
            
            self.arrayOfViews.append(viewContainer)
        }
        self.updateViews(number: 0)
    }
    
    private func getInsets() -> UIEdgeInsets {
        let totalCellWidth = (self.containerWidth * 2) * self.numberOfPages
        
        let horizontalInset = (self.bounds.width - CGFloat(totalCellWidth)) / 2
        let verticalInset = (self.bounds.size.height - CGFloat(self.containerHeight)) / 2

        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.prepareLayout()
    }

    // MARK: -
    // MARK: DataSource
    
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
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollDelegate?.scrollTo(page: indexPath)
    }
}
