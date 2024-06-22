//
//  UICollectionReusableView + Extension.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

extension UICollectionReusableView {
    
    static var identifier: String {
        String(describing: classForCoder())
    }
    
    var identifier: String {
        String(describing: classForCoder)
    }
}
