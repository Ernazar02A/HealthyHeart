//
//  
//  HomeViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import UIKit
import SnapKit

protocol HomeScreen: AnyObject {
    var presenter: IHomePresenter! { get set }
}

typealias IHomeViewController = BaseViewController & HomeScreen

class HomeViewController: IHomeViewController {
    
    var presenter: IHomePresenter!
    
    override func setup() {
        super.setup()
        presenter.setDelegate(self)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        view.backgroundColor = themeProperties.bgPrimary
    }
    
    override func commonInit() {
        super.commonInit()
        hidesBottomBarWhenPushed = false
    }
}

extension HomeViewController: IHomeDelegate {
    
}
