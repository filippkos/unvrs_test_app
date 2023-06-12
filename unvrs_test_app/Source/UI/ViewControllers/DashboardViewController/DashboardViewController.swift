//
//  DashboardViewController.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

class DashboardViewController: UIViewController, RootViewGettable, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ScrollToPageProtocol {

    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = DashboardView
    
    // MARK: -
    // MARK: Variables
    
    private var contentModels: [DashboardContentModel] = []
    
    // MARK: -
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView?.dataSource = self
        self.rootView?.collectionView?.delegate = self
        self.rootView?.pager?.scrollDelegate = self
        self.rootView?.collectionView?.register(cellClass: DashboardCollectionViewCell.self)
        self.rootView?.configure()
        self.rootView?.flowLayoutConfigure()
        self.fillContentModels()
    }
    
    // MARK: -
    // MARK: Private
    
    private func fillContentModels() {
        for model in DashboardContentModel.allCases {
            self.contentModels.append(model)
        }
    }
    
    func scrollTo(page: IndexPath) {
        self.rootView?.collectionView?.scrollToItem(at: page, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: -
    // MARK: CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: DashboardCollectionViewCell.self, indexPath: indexPath)
        cell.configure(model: self.contentModels[indexPath.row], index: indexPath.row)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.size.width - 62
        let itemHeight = collectionView.frame.size.height
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // MARK: -
    // MARK: CollectionView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.rootView?.configurePager()
    }
}
