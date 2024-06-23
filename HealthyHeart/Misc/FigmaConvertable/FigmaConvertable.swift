//
//  FigmaConvertable.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

protocol IFigmaConvertible {
    var screenHeight: CGFloat { get }
    var screenWidth: CGFloat { get }
    
    func heightComputed(_ value: CGFloat) -> CGFloat
    func widthComputed(_ value: CGFloat) -> CGFloat
    
    static var screenHeight: CGFloat { get }
    static var screenWidth: CGFloat { get }
    
    static func heightComputed(_ value: CGFloat) -> CGFloat
    static func widthComputed(_ value: CGFloat) -> CGFloat
}

extension IFigmaConvertible {
    private static var figmaScreenHeight: CGFloat { 852 }
    private static var figmaScreenWidth: CGFloat { 393 }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func heightComputed(_ value: CGFloat) -> CGFloat {
        return screenHeight * value / Self.figmaScreenHeight
    }
    
    func widthComputed(_ value: CGFloat) -> CGFloat {
        return screenWidth * value / Self.figmaScreenWidth
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static func heightComputed(_ value: CGFloat) -> CGFloat {
        return screenHeight * value / figmaScreenHeight
    }
    
    static func widthComputed(_ value: CGFloat) -> CGFloat {
        return screenWidth * value / figmaScreenWidth
    }
}

