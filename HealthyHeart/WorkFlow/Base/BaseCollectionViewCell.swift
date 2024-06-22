//
//  BaseCollectionViewCell.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, IFigmaConvertible, IThemeApplyable {

    private static var prototypes = [String: BaseCollectionViewCell]()
    
    class var prototype: Self {
        let key = Self.identifier
        if let prototype = prototypes[key] {
            return prototype as! Self
        }
        let prototype = Self()
        prototypes[key] = prototype
        return prototype
    }
    
    
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
