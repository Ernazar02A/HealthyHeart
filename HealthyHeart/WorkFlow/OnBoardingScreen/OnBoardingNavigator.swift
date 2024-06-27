//
//  
//  OnBoardingNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 23/6/24.
//
//

import UIKit

protocol IOnBoardingNavigator {
    func presentAuthScreen()
}

struct OnBoardingNavigator: IOnBoardingNavigator {
    
    weak var viewController: IOnBoardingViewController!
    
    func presentAuthScreen() {
        let navVc = UINavigationController(rootViewController: (Dependency.resolve(IAuthViewController.self)))
        navVc.modalPresentationStyle = .fullScreen
        viewController.navigationController?.present(navVc, animated: true)
    }
}

