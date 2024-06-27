//
//  MainButton.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 14/6/24.
//

import UIKit

final class MainButton: UIButton, IThemeApplyable {
    
    init(isActive: Bool) {
        super.init(frame: .zero)
        setupButton()
        changeActiveBackgroundButton(state: isActive)
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
        backgroundColor = themeProperties.blue
        setTitleColor(themeProperties.textWhite, for: .normal)
    }
    
    func changeActiveBackgroundButton(state: Bool) {
        backgroundColor = state ? Theme.shared.blue : Theme.shared.bgGray
        isEnabled = state
    }
}
