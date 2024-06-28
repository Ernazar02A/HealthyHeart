//
//  
//  TabBarNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import UIKit

protocol ITabBarNavigator {
    func setupViewControllers()
}

struct TabBarNavigator: ITabBarNavigator {
    
    weak var viewController: ITabBarViewController!
    
    func setupViewControllers() {
        viewController.setViewControllers(
            [
                clientsFlow(),
                lodgingFlow(),
                faqFlow(),
                profileFlow()
            ],
            animated: false
        )
    }
    
    private func clientsFlow() -> BaseNavigationController {
        let vc = Dependency.resolve(IHomeViewController.self)
        vc.tabBarItem.setTitleTextAttributes([.font: UIFont.h11SemiBold], for: .normal)
        vc.tabBarItem.title = "Главная"
        vc.tabBarItem.image = .houseIcon
        let nav = BaseNavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
    
    private func lodgingFlow() -> BaseNavigationController {
        let vc = Dependency.resolve(IAnalyticsViewController.self)
        vc.tabBarItem.setTitleTextAttributes([.font: UIFont.h11SemiBold], for: .normal)
        vc.tabBarItem.title = "Аналитика"
        vc.tabBarItem.image = .analyticIcon
        let nav = BaseNavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
    
    private func faqFlow() -> BaseNavigationController {
        let vc = Dependency.resolve(IDoctorsViewController.self)
        vc.tabBarItem.setTitleTextAttributes([.font: UIFont.h11SemiBold], for: .normal)
        vc.tabBarItem.title = "Врачи"
        vc.tabBarItem.image = .personsIcon
        let nav = BaseNavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
    
    private func profileFlow() -> BaseNavigationController {
        let vc = Dependency.resolve(IReminderViewController.self)
        vc.tabBarItem.setTitleTextAttributes([.font: UIFont.h11SemiBold], for: .normal)
        vc.tabBarItem.title = "Напоминание"
        vc.tabBarItem.image = .stopwatchIcon
        let nav = BaseNavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
}

