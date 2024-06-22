//
//  UIButton + Extension.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 15/6/24.
//

import UIKit

extension UIButton {
    
    func animationTapButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
