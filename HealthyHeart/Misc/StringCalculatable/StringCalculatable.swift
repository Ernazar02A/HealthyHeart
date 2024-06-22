//
//  StringCalculatable.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

protocol IStringSizeCalculatable {
    
}

extension IStringSizeCalculatable {
    func computedTextSize(
        text: String,
        font: UIFont,
        maxWidth: CGFloat = .greatestFiniteMagnitude,
        maxHeight: CGFloat = .greatestFiniteMagnitude
    ) -> CGSize {
        let constaintSize = CGSize(width: maxWidth, height: maxHeight)
        let boundingRect = text.boundingRect(
            with: constaintSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return CGSize(width: ceil(boundingRect.width), height: ceil(boundingRect.height))
    }
}

