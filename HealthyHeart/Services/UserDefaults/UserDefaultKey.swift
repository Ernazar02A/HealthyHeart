//
//  UserDefaultKey.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import Foundation

private enum Key: String {
    case language
    case theme
    case isReadOnBoarding
}

struct UserDefaultsKey<Value: Codable> {
    private let key: Key
    
    var value: String {
        return key.rawValue
    }
}

enum UserDefaultsLanguage: String, Codable {
    case russian
    case kyrgyz
    case english
    
    var localizableKey: String {
        switch self {
        case .russian:
            return "ru"
        case .kyrgyz:
            return "ky"
        case .english:
            return "en"
        }
    }
    
    var headerValue: String {
        switch self {
        case .russian:
            return "ru"
        case .kyrgyz:
            return "ky"
        case .english:
            return "en"
        }
    }
    
    var tripleCharValue: String {
        switch self {
        case .russian:
            return "RUS"
        case .kyrgyz:
            return "KYR"
        case .english:
            return "ENG"
        }
    }
    
    var identifiers: String {
        switch self {
        case .russian:
            return "ru_RU"
        case .kyrgyz:
            return "en_US"
        case .english:
            return "ky_KG"
        }
    }
}

enum UserDefaultsTheme: String, Codable {
    case light
    case dark
    case system
}

extension UserDefaultsKey {
   
    static var language: UserDefaultsKey<UserDefaultsLanguage> {
        return UserDefaultsKey<UserDefaultsLanguage>(key: .language)
    }
    
    static var theme: UserDefaultsKey<UserDefaultsTheme> {
        return UserDefaultsKey<UserDefaultsTheme>(key: .theme)
    }
    
    static var isReadOnBoarding: UserDefaultsKey<Bool> {
        return UserDefaultsKey<Bool>(key: .isReadOnBoarding)
    }
}
