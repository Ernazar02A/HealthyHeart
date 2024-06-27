//
//  
//  SuccessfulLoginRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import Foundation

extension Dependency {
    static func registerSuccessfulLoginScreen() {
        register(ISuccessfulLoginNavigator.self) { resolver, args in
            SuccessfulLoginNavigator(
                viewController: args.get()
            )
        }
        register(ISuccessfulLoginPresenter.self) { resolver, args in
            SuccessfulLoginPresenter(
                navigator: resolver.resolve(args: args.get("vc"))
            )
        }
        register(ISuccessfulLoginViewController.self) {
            SuccessfulLoginViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

