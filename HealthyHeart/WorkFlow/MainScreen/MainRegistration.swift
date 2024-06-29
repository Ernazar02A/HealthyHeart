//
//  
//  MainRegistration.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//
//

import Foundation

extension Dependency {
    static func registerMainScreen() {
        register(IMainNavigator.self) { resolver, args in
            MainNavigator(
                viewController: args.get()
            )
        }
        register(IMainPresenter.self) { resolver, args in
            MainPresenter(
                navigator: resolver.resolve(args: args.get("vc"))
            )
        }
        register(IMainViewController.self) {
            MainViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

