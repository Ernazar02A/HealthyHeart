//
//  Dependency.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import Foundation
import Resolver

fileprivate struct Config {
    static let baseURL = URL(string: "http://157.230.120.99:81/api/v1/profiles/")
    static let keychainAccessKey = Bundle.main.bundleIdentifier!
}

extension Resolver.Name {
    static let baseURL = Self("baseURL")
    static let deviceID = Self("deviceID")
    static let defaultLocker = Self("defaultLocker")
    static let keychainAccessKey = Self("keychainAccessKey")
}

struct Dependency {
    
    static func resolve<Service>(
        _ type: Service.Type = Service.self,
        name: Resolver.Name? = nil,
        args: [String: Any]? = nil
    ) -> Service {
        Resolver.resolve(type, name: name, args: args)
    }
    
    @discardableResult static func register<Service>(
        _ type: Service.Type = Service.self,
        name: Resolver.Name? = nil,
        factory: @escaping ResolverFactoryArgumentsN<Service>
    ) -> ResolverOptions<Service> {
        Resolver.register(type, name: name, factory: factory)
    }
    
    @discardableResult static func register<Service>(
        _ type: Service.Type = Service.self,
        name: Resolver.Name? = nil,
        factory: @escaping ResolverFactory<Service>
    ) -> ResolverOptions<Service> {
        Resolver.register(type, name: name, factory: factory)
    }
    
    @discardableResult static func register<Service>(
        _ type: Service.Type = Service.self,
        name: Resolver.Name? = nil,
        factory: @escaping ResolverFactoryResolver<Service>
    ) -> ResolverOptions<Service> {
        Resolver.register(type, name: name, factory: factory)
    }
    
    fileprivate static func registerAllServices() {
        registerConstants()
        registerUseCases()
        registerServices()
        registerScreens()
    }
    
    fileprivate static func registerUseCases() {
        registerAuthUseCase()
    }
    
    fileprivate static func registerServices() {
        registerKeyChainService()
        registerUserDefaultsService()
        registerDefaultScreenLocker()
        registerValidatorService()
    }
    
    fileprivate static func registerConstants() {
        register(name: .baseURL) {
            Config.baseURL
        }
        register(name: .keychainAccessKey) {
            Config.keychainAccessKey
        }
    }
    
    fileprivate static func registerScreens() {
        registerOnBoardingScreen()
        registerAuthScreen()
        registerConfirmNumberScreen()
        registerSuccessfulLoginScreen()
        registerUserInformationFormScreen()
        registerTabBarScreen()
        registerHomeScreen()
        registerAnalyticsScreen()
        registerDoctorsScreen()
        registerReminderScreen()
    }
}

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        Dependency.registerAllServices()
    }
    
    func optional<Service>(
        _ type: Service.Type = Service.self,
        name: Resolver.Name? = nil,
        args: [String: Any]? = nil
    ) -> Service? {
        Resolver.optional(type, name: name, args: args)
    }
}


