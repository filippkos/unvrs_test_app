//
//  DashboardViewController.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

class DashboardViewController: UIViewController, RootViewGettable, UICollectionViewDataSource {

    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = DashboardView
    
    // MARK: -
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView?.dataSource = self
        self.rootView?.collectionView?.register(cellClass: DashboardCollectionViewCell.self)
        self.rootView?.configure()
        self.rootView?.flowLayoutConfigure()
    }
    
    // MARK: -
    // MARK: CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: DashboardCollectionViewCell.self, indexPath: indexPath)
        
        return cell
    }
}
