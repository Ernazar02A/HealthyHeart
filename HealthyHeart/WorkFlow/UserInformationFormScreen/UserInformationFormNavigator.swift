//
//  
//  UserInformationFormNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import UIKit

protocol IUserInformationFormNavigator: IAlertPresentable {
    func presentTabBar()
}

struct UserInformationFormNavigator: IUserInformationFormNavigator {
    
    var viewControllerToPresentAlert: UIViewController {
        return viewController
    }
    
    weak var viewController: IUserInformationFormViewController!
    
    func presentTabBar() {
        print("presentTabBar")
    }
}

