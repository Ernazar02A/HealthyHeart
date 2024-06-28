//
//  
//  SuccessfulLoginNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import Foundation

protocol ISuccessfulLoginNavigator {
    func pushInputScreen()
}

struct SuccessfulLoginNavigator: ISuccessfulLoginNavigator {
    
    weak var viewController: ISuccessfulLoginViewController!
    
    func pushInputScreen() {
        let vc = Dependency.resolve(IUserInformationFormViewController.self)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

