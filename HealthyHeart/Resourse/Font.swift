//
//  Font.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

public enum SFProFont: IFigmaConvertible {
    case h11Regular
    case h17Regular
    case h11SemiBold
    case h17SemiBold
    case h28Bold
    
    case custom(size: CGFloat)
    
    public var font: UIFont {
        switch self {
        case .h11Regular:
            return UIFont.systemFont(ofSize: heightComputed(11), weight: .regular)
        case .h17Regular:
            return UIFont.systemFont(ofSize: heightComputed(17), weight: .regular)
        case .h11SemiBold:
            return UIFont.systemFont(ofSize: heightComputed(11), weight: .semibold)
        case .h17SemiBold:
            return UIFont.systemFont(ofSize: heightComputed(17), weight: .semibold)
        case .h28Bold:
            return UIFont.systemFont(ofSize: heightComputed(28), weight: .bold)
        case .custom(let size):
            return UIFont.systemFont(ofSize: heightComputed(size))
        }
    }
}

extension UIFont {
    static let h11Regular = SFProFont.h11Regular.font
    static let h17Regular = SFProFont.h17Regular.font
    static let h11SemiBold = SFProFont.h11SemiBold.font
    static let h17SemiBold = SFProFont.h17SemiBold.font
    static let h28Bold = SFProFont.h28Bold.font
    static func custom(with size: CGFloat) -> UIFont {
        return SFProFont.custom(size: size).font
    }
}
