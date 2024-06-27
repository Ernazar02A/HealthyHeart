//
//  
//  ConfirmNumberRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import Foundation

extension Dependency {
    static func registerConfirmNumberScreen() {
        register(IConfirmNumberNavigator.self) { resolver, args in
            ConfirmNumberNavigator(
                viewController: args.get()
            )
        }
        register(IConfirmNumberPresenter.self) { resolver, args in
            ConfirmNumberPresenter(
                navigator: resolver.resolve(args: args.get("vc")),
                authUseCase: resolver.resolve(),
                number: args.get("number"),
                secretKey: args.get("secretKey")
            )
        }
        register(IConfirmNumberViewController.self) {
            ConfirmNumberViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            arguments["number"] = args.get("number")
            arguments["secretKey"] = args.get("secretKey")
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

