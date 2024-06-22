//
//  ThemeApplyable.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

protocol IThemeApplyable {
    func applyThemeProperties(_ themeProperties: ThemeProperties)
}

extension IThemeApplyable where Self: UIViewController {
    
    var themeProperties: ThemeProperties {
        Theme.shared
    }
}

extension IThemeApplyable where Self: UIView {
    
    var themeProperties: ThemeProperties {
        return Theme.shared
    }
}

