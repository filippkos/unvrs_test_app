//
//  UViewController+ViewCast.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

protocol RootViewGettable: UIViewController {
    
    associatedtype RootView: UIView
    var rootView: RootView? { get }
}

extension RootViewGettable {
    var rootView: RootView? {
        self.view as? RootView
    }
}
