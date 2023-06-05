//
//  Coordinator.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

class Coordinator {

    // MARK: -
    // MARK: Variables
    
    let navigationController: UINavigationController
    
    // MARK: -
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.prepareDashBoardViewController()
    }
    
    private func prepareDashBoardViewController() {
        let controller = DashboardViewController()
        
        self.navigationController.setViewControllers([controller], animated: true)
    }
}
