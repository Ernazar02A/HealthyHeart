//
//  UIView+Extension.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

extension UIView {
    
    @resultBuilder
    struct SubviewBuilder {
        static func buildBlock(_ components: UIView...) -> [UIView] { components }
    }
    
    func add(@SubviewBuilder _ components: () -> [UIView]) {
        components().forEach(addSubview)
    }
}

