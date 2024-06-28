//
//  
//  TabBarPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

//protocol ITabBarDelegate: AnyObject {
//    
//}
//
//protocol ITabBarPresenter {
//    func setDelegate(_ delegate: ITabBarDelegate)
//    func setupViewControllers()
//}
//
//class TabBarPresenter: ITabBarPresenter {
//    
//    let navigator: ITabBarNavigator
//    
//    weak var delegate: ITabBarDelegate?
//    
//    init(navigator: ITabBarNavigator) {
//        self.navigator = navigator
//    }
//    
//    func setDelegate(_ delegate: ITabBarDelegate) {
//        self.delegate = delegate
//    }
//    
//    func setupViewControllers() {
//        navigator.setupViewControllers()
//    }
//}

protocol ITabBarDelegate: AnyObject {
    
}

protocol ITabBarPresenter {
    func setDelegate(_ delegate: ITabBarDelegate)
    func setupViewControllers()
}

class TabBarPresenter: ITabBarPresenter {
    
    let navigator: ITabBarNavigator
    
    weak var delegate: ITabBarDelegate?
    
    init(navigator: ITabBarNavigator) {
        self.navigator = navigator
    }
    
    func setDelegate(_ delegate: ITabBarDelegate) {
        self.delegate = delegate
    }
    
    func setupViewControllers() {
        navigator.setupViewControllers()
    }
}
