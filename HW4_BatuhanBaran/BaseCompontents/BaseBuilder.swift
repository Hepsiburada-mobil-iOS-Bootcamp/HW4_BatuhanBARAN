//
//  BaseBuilder.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import UIKit

// todo generic value
enum ScreenType {
    case fullScreen
    case modal
}

class BaseBuilder<T: UIViewController> {
    var viewController = T()
    
    func build(with screenType: ScreenType) -> T {
        switch screenType {
        case .fullScreen:
            viewController.modalPresentationStyle = .fullScreen
            return viewController
        case .modal:
            return viewController
        }
    }
}
