//
//  
//  AuthRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import Foundation

extension Dependency {
    static func registerAuthScreen() {
        register(IAuthNavigator.self) { resolver, args in
            AuthNavigator(
                viewController: args.get()
            )
        }
        register(IAuthPresenter.self) { resolver, args in
            AuthPresenter(
                navigator: resolver.resolve(args: args.get("vc")), 
                authUseCase: resolver.resolve()
            )
        }
        register(IAuthViewController.self) {
            AuthViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

