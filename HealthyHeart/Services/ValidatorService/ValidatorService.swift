//
//  ValidatorService.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 16/6/24.
//

import Foundation

extension Dependency {
    static func registerValidatorService() {
        register(IValidatorService.self) { resolver in
            ValidatorService()
        }
    }
}

protocol IValidatorService {
    func isValidEmail(_ email: String) -> Bool
    func validatePassword(_ password: String) -> Bool
}

final class ValidatorService: IValidatorService {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        guard password.count >= 8 else { return false }
        
        let characterSets: [CharacterSet] = [.lowercaseLetters, .decimalDigits, .uppercaseLetters]
        
        for charset in characterSets {
            guard password.rangeOfCharacter(from: charset) != nil else { return false }
        }
        
        return true
    }
}
