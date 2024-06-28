//
//  
//  DoctorsViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import UIKit
import SnapKit

protocol DoctorsScreen: AnyObject {
    var presenter: IDoctorsPresenter! { get set }
}

typealias IDoctorsViewController = BaseViewController & DoctorsScreen

class DoctorsViewController: IDoctorsViewController {
    
    var presenter: IDoctorsPresenter!
    
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

extension DoctorsViewController: IDoctorsDelegate {
    
}
