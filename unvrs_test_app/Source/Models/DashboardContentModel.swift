//
//  DashboardContentModel.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

enum DashboardContentModel: CaseIterable {
    
    case first
    case second
    case third
    case fourth
    
    var isVisible: Bool {
        self == .third
    }
    
    var title: String {
        switch self {
        case .first:
            return "Your Personal Assistant"
        case .second:
            return "Get assistance with any topic"
        case .third:
            return "Perfect copy you can rely on"
        case .fourth:
            return "Upgrade for Unlimited AI Capabilities"
        }
    }
    
    var description: String {
        switch self {
        case .first:
            return "Simplify your life with an AI companion"
        case .second:
            return "From daily tasks to complex queries, we’ve got you covered"
        case .third:
            return "Generate professional texts effortlessly"
        case .fourth:
            return "7-Day Free Trial, then $19.99/month, auto-renewable"
        }
    }
    
    var image: UIImage {
        switch self {
        case .first:
            return UIImage(named: "Illustration1") ?? UIImage()
        case .second:
            return UIImage(named: "Illustration2") ?? UIImage()
        case .third:
            return UIImage(named: "Illustration3") ?? UIImage()
        case .fourth:
            return UIImage(named: "Illustration4") ?? UIImage()
        }
    }
}
