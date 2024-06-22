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
        titleLabel?.font = .h16Bold
        layer.cornerRadius = 10
        applyThemeProperties(themeProperties)
    }
    
    func applyThemeProperties(_ themeProperties: ThemeProperties) {
        backgroundColor = themeProperties.skyBlueColor
        setTitleColor(themeProperties.white, for: .normal)
    }
    
    func changeActiveBorderButton(state: Bool) {
        backgroundColor = state ? Theme.shared.activeButtonColor : .clear
        isEnabled = state
        layer.borderWidth = state ? 0 : 1
        layer.borderColor = Theme.shared.lightBluishGray.cgColor
        setTitleColor(state ? Theme.shared.white : Theme.shared.blueGrayColor, for: .normal)
    }
    
    func changeActiveBackgroundButton(state: Bool) {
        backgroundColor = state ? Theme.shared.activeButtonColor : Theme.shared.lightBluishGray
        isEnabled = state
    }
}
