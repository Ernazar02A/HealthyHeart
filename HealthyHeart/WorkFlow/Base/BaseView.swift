//
//  BaseView.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

class BaseView: UIView, IFigmaConvertible, IThemeApplyable, IStringSizeCalculatable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
