//
//  
//  ConfirmNumberNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import UIKit

protocol IConfirmNumberNavigator: IAlertPresentable {
    func presentSuccessVerificationScreen()
    func presentTabBarScreen()
}

struct ConfirmNumberNavigator: IConfirmNumberNavigator {
    
    var viewControllerToPresentAlert: UIViewController {
        return viewController
    }
    
    weak var viewController: IConfirmNumberViewController!
    
    func presentSuccessVerificationScreen() {
        print("presentSuccessVerificationScreen")
    }
    
    func presentTabBarScreen() {
        print("presentTabBarScreen")
    }
}

