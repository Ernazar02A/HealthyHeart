//
//  KeychainService.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import KeychainAccess
import Resolver
import Foundation

extension Dependency {
    static func registerKeyChainService() {
        register(IKeyChainService.self) { resolver in
            KeyChainService(service: resolver.resolve(name: .keychainAccessKey))
        }
    }
}

protocol IKeyChainService {
    func getValue<Value: Codable>(for key: KeychainKey<Value>) -> Value?
    func setValue<Value: Codable>(_ value: Value?, for key: KeychainKey<Value>)
    func deleteAll()
}

private struct KeyChainService: IKeyChainService {
    
    private let keychain: Keychain

    init(service: String) {
        self.keychain = Keychain(service: service)
    }
    
    func getValue<Value: Codable>(for key: KeychainKey<Value>) -> Value? {
        guard let data = keychain[data: key.value] else { return nil }
        return try? JSONDecoder().decode(Value.self, from: data)
    }
    
    func setValue<Value: Codable>(_ value: Value?, for key: KeychainKey<Value>) {
        keychain[data: key.value] = try? JSONEncoder().encode(value)
    }
    
    func deleteAll() {
        try? keychain.removeAll()
    }
}

