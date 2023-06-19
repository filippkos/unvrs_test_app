//
//  DashboardViewController.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

import RxSwift
import RxCocoa

enum DashboardViewControllerOutputEvents {
    
    case showTermsOfUseAndPrivacyPolicy
    case showSubscriptionTerms
}

class DashboardViewController: UIViewController, RootViewGettable, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ScrollToPageProtocol {

    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = DashboardView
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((DashboardViewControllerOutputEvents)->())?
    private var contentModels: [DashboardContentModel] = []

    private let numberOfPages = 4
    private let dispose = DisposeBag()
    
    // MARK: -
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView?.dataSource = self
        self.rootView?.collectionView?.delegate = self
        self.rootView?.pager?.scrollDelegate = self
        self.rootView?.collectionView?.register(cellClass: DashboardCollectionViewCell.self)
        self.rootView?.configure(outputEvents: { [weak self] event in
            switch event {
            case .showTermsOfUseAndPrivacyPolicy:
                self?.outputEvents?(.showTermsOfUseAndPrivacyPolicy)
            case .showSubscriptionTerms:
                self?.outputEvents?(.showSubscriptionTerms)
            }
        })
        self.fillContentModels()
        self.bind()
    }
    
    // MARK: -
    // MARK: Public
    
    private func bind() {
        self.rootView?.button?
            .rx
            .tap
            .bind { [weak self] in
                let currentPage = self?.rootView?.pager?.actualPage
                if currentPage ?? 0 < (self?.numberOfPages ?? 0) - 1 {
                    self?.scrollTo(page: IndexPath(row: (currentPage ?? 0) + 1, section: 0))
                }
            }
            .self.disposed(by: self.dispose)
    }
    
    func scrollTo(page: IndexPath) {
        self.rootView?.collectionView?.scrollToItem(at: page, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: -
    // MARK: Private
    
    private func fillContentModels() {
        for model in DashboardContentModel.allCases {
            self.contentModels.append(model)
        }
    }
    
    // MARK: -
    // MARK: CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfPages
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
