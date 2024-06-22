//
//  BaseViewController.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit
import Reachability

class BaseViewController: UIViewController, IFigmaConvertible, IThemeApplyable, IStringSizeCalculatable {
        
    let reachability = try! Reachability()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func commonInit() {
        hidesBottomBarWhenPushed = true
    }
    
    func setup() {
        setupSubviews()
        setupConstraints()
        applyLocalization()
        applyThemeProperties(themeProperties)
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func applyLocalization() {
        
    }
    
    func applyThemeProperties(_ themeProperties: ThemeProperties) {

    }
}
