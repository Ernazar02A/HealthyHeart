//
//  MainButton.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 14/6/24.
//

import UIKit

final class MainButton: UIButton, IThemeApplyable {
    
    init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        titleLabel?.font = .h17SemiBold
        layer.cornerRadius = 10
        applyThemeProperties(themeProperties)
    }
    
    func applyThemeProperties(_ themeProperties: ThemeProperties) {
        backgroundColor = themeProperties.bgRedDefault
        setTitleColor(themeProperties.textWhite, for: .normal)
    }
    
    func changeActiveBackgroundButton(state: Bool) {
        backgroundColor = state ? Theme.shared.bgRedDefault : Theme.shared.bgGray
        isEnabled = state
    }
}
