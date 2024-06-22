//
//  Theme.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

protocol ThemeProperties {
    var bgGray: UIColor { get }
    var bgGrayDefault: UIColor { get }
    var bgLightGray: UIColor { get }
    var bgRedDefault: UIColor { get }
    var textDarkDefault: UIColor { get }
    var textDarkGray: UIColor { get }
    var textGray: UIColor { get }
    var textRedDefault: UIColor { get }
    var textWhite: UIColor { get }
}

struct Theme: ThemeProperties {
    
    static let shared = Theme()
    
    var bgGray: UIColor = UIColor(named: "bg_gray")!
    
    var bgGrayDefault: UIColor = UIColor(named: "bg_gray_default")!
    
    var bgLightGray: UIColor = UIColor(named: "bg_light_gray")!
    
    var bgRedDefault: UIColor = UIColor(named: "bg_red_default")!
    
    var textDarkDefault: UIColor = UIColor(named: "text_dark_default")!
    
    var textDarkGray: UIColor = UIColor(named: "text_dark_gray")!
    
    var textGray: UIColor = UIColor(named: "text_gray")!
    
    var textRedDefault: UIColor = UIColor(named: "text_red_default")!
    
    var textWhite: UIColor = UIColor(named: "text_white")!
}
