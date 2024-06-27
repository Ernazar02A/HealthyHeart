//
//  ResendButton.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//

import UIKit

class ResendButton: UIButton, IFigmaConvertible, IThemeApplyable, IStringSizeCalculatable {
    
    private var timer: Timer?
    private var secondsRemaining: Int = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        applyLocalization()
        applyThemeProperties(themeProperties)
        setupButton()
        startTimer()
    }

    func applyLocalization() {
        setTitle("Отправить код заново через \(secondsRemaining)", for: .normal)
    }
    
    func applyThemeProperties(_ themeProperties: ThemeProperties) {
        setTitleColor(.systemBlue, for: .normal)
    }
    
    private func setupButton() {
        titleLabel?.font = .h17Regular
        isEnabled = false
    }
    
    private func startTimer() {
        timer?.invalidate()
        secondsRemaining = 60
        isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            setTitle("Отправить код заново через \(secondsRemaining)", for: .normal)
        } else {
            timer?.invalidate()
            setTitle("Отправить код заново", for: .normal)
            isEnabled = true
        }
    }
    
    func resetTimer() {
        startTimer()
    }
}
