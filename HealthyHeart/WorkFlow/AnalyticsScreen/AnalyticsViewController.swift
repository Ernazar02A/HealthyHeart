//
//  
//  AnalyticsViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import UIKit
import SnapKit

protocol AnalyticsScreen: AnyObject {
    var presenter: IAnalyticsPresenter! { get set }
}

typealias IAnalyticsViewController = BaseViewController & AnalyticsScreen

class AnalyticsViewController: IAnalyticsViewController {
    
    var presenter: IAnalyticsPresenter!
    
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

extension AnalyticsViewController: IAnalyticsDelegate {
    
}
