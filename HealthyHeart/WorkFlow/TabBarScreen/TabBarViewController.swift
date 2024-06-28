//
//  
//  TabBarViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import UIKit
import SnapKit

protocol TabBarScreen: AnyObject {
    var presenter: ITabBarPresenter! { get set }
}

typealias ITabBarViewController = UITabBarController & TabBarScreen

class TabBarViewController: ITabBarViewController, IFigmaConvertible {
    
    var presenter: ITabBarPresenter! {
        didSet {
            presenter.setupViewControllers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setup() {
        applyThemeProperties(Theme.shared)
    }
  
    func applyThemeProperties(_ themeProperties: ThemeProperties) {
        tabBar.tintColor = themeProperties.blue
        tabBar.backgroundColor = themeProperties.bgPrimary
    }
}

extension TabBarViewController: ITabBarDelegate {
    
}
