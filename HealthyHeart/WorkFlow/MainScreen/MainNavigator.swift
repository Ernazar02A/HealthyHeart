//
//  
//  MainNavigator.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//
//

import UIKit

protocol IMainNavigator: IAlertPresentable {
    func pushToProfile()
    func pushToNotifications()
}

struct MainNavigator: IMainNavigator {

    weak var viewController: IMainViewController!
    
    var viewControllerToPresentAlert: UIViewController {
        return viewController
    }
    
    func pushToProfile() {
        print("navigator.pushToProfile")
    }
    
    func pushToNotifications() {
        print("navigator.pushToNotifications")
    }
}

