//
//  KeychainKey.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import Foundation

private enum Key: String {
    case baseUrl
    case sessionToken
    case refreshToken
    case verificationToken
    case fcmToken
}

struct KeychainKey<Value: Codable> {
    private let key: Key
    
    var value: String {
        return key.rawValue
    }
}

extension KeychainKey {
    static var accessToken: KeychainKey<String> {
        return KeychainKey<String>(key: .sessionToken)
    }
    
    static var refreshToken: KeychainKey<String> {
        return KeychainKey<String>(key: .refreshToken)
    }
    
    static var verificationToken: KeychainKey<String> {
        return KeychainKey<String>(key: .verificationToken)
    }
    
    static var fcmToken: KeychainKey<String> {
        return KeychainKey<String>(key: .fcmToken)
    }
    
    static var baseURL: KeychainKey<URL> {
        return KeychainKey<URL>(key: .baseUrl)
    }
    
    static func makeKey(from account: String) -> KeychainKey<String>? {
        guard let key = Key(rawValue: account) else {
            print("Invalid key: \(account)")
            return nil
        }
        return KeychainKey<String>(key: key)
    }
}
