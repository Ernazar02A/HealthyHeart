//
//  UserDefaultsService.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import Foundation

extension Dependency {
    static func registerUserDefaultsService() {
        register(IUserDefaultsService.self) {
            UserDefaultsService()
        }
    }
}

protocol IUserDefaultsService {
    func getValue<Value: Codable>(for key: UserDefaultsKey<Value>) -> Value?
    func setValue<Value: Codable>(_ value: Value?, for key: UserDefaultsKey<Value>)
}

private struct UserDefaultsService: IUserDefaultsService {
    private let storage: UserDefaults
    
    init() {
        storage = UserDefaults.standard
    }
    
    func getValue<Value: Codable>(for key: UserDefaultsKey<Value>) -> Value? {
        guard
            let data = storage.data(forKey: key.value),
            let value = try? JSONDecoder().decode(Value.self, from: data)
        else { return nil }
        return value
    }
    
    func setValue<Value: Codable>(_ value: Value?, for key: UserDefaultsKey<Value>) {
        storage.set(try? JSONEncoder().encode(value), forKey: key.value)
    }
}
