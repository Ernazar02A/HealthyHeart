//
//  BaseTableViewCell.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell, IFigmaConvertible, IThemeApplyable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
