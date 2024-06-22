//
//  Font.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

public enum SFProFont: IFigmaConvertible {
    case h12Regular
    case h13Regular
    case h14Regular
    case h16Regular
    case h14Medium
    case h14SemiBold
    case h16SemiBold
    case h18SemiBold
    case h14Bold
    case h16Bold
    case h20Bold
    case h21Bold
    case h22Bold
    case h24Bold
    
    case custom(size: CGFloat)
    
    public var font: UIFont {
        switch self {
        case .h12Regular:
            return UIFont.systemFont(ofSize: heightComputed(12), weight: .regular)
        case .h13Regular:
            return UIFont.systemFont(ofSize: heightComputed(13), weight: .regular)
        case .h14Regular:
            return UIFont.systemFont(ofSize: heightComputed(14), weight: .regular)
        case .h16Regular:
            return UIFont.systemFont(ofSize: heightComputed(16), weight: .regular)
        case .h14Medium:
            return UIFont.systemFont(ofSize: heightComputed(14), weight: .medium)
        case .h14SemiBold:
            return UIFont.systemFont(ofSize: heightComputed(14), weight: .semibold)
        case .h16SemiBold:
            return UIFont.systemFont(ofSize: heightComputed(16), weight: .semibold)
        case .h18SemiBold:
            return UIFont.systemFont(ofSize: heightComputed(18), weight: .semibold)
        case .h14Bold:
            return UIFont.systemFont(ofSize: heightComputed(14), weight: .bold)
        case .h16Bold:
            return UIFont.systemFont(ofSize: heightComputed(16), weight: .bold)
        case .h20Bold:
            return UIFont.systemFont(ofSize: heightComputed(20), weight: .bold)
        case .h21Bold:
            return UIFont.systemFont(ofSize: heightComputed(21), weight: .bold)
        case .h22Bold:
            return UIFont.systemFont(ofSize: heightComputed(22), weight: .bold)
        case .h24Bold:
            return UIFont.systemFont(ofSize: heightComputed(24), weight: .bold)
        case .custom(let size):
            return UIFont.systemFont(ofSize: heightComputed(size))
        }
    }
}

extension UIFont {
    static let h12Regular = SFProFont.h12Regular.font
    static let h13Regular = SFProFont.h13Regular.font
    static let h14Regular = SFProFont.h14Regular.font
    static let h16Regular = SFProFont.h16Regular.font
    static let h14Medium = SFProFont.h14Medium.font
    static let h14SemiBold = SFProFont.h14SemiBold.font
    static let h16SemiBold = SFProFont.h16SemiBold.font
    static let h18SemiBold = SFProFont.h18SemiBold.font
    static let h14Bold = SFProFont.h14Bold.font
    static let h16Bold = SFProFont.h16Bold.font
    static let h20Bold = SFProFont.h20Bold.font
    static let h21Bold = SFProFont.h21Bold.font
    static let h22Bold = SFProFont.h22Bold.font
    static let h24Bold = SFProFont.h24Bold.font
    static func custom(with size: CGFloat) -> UIFont {
        return SFProFont.custom(size: size).font
    }
}
