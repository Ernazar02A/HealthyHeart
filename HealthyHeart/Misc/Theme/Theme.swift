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
    var textDarkDefault: UIColor { get }
    var textDarkGray: UIColor { get }
    var textWhite: UIColor { get }
    var blue: UIColor { get }
    var labelSecondary: UIColor { get }
    var labelPrimary: UIColor { get }
    var bgPrimary: UIColor { get }
}

struct Theme: ThemeProperties {
    
    static let shared = Theme()
    
    var bgGray: UIColor = UIColor(named: "bg_gray")!
    
    var bgGrayDefault: UIColor = UIColor(named: "bg_gray_default")!
            
    var textDarkDefault: UIColor = UIColor(named: "text_dark_default")!
    
    var textDarkGray: UIColor = UIColor(named: "text_dark_gray")!
            
    var textWhite: UIColor = UIColor(named: "text_white")!
    
    var blue: UIColor = UIColor(named: "blue")!
    
    var labelSecondary: UIColor = UIColor(named: "label_secondary")!
    
    var labelPrimary: UIColor = UIColor(named: "label_primary")!
    
    var bgPrimary: UIColor = UIColor(named: "bg_primary")!
}
