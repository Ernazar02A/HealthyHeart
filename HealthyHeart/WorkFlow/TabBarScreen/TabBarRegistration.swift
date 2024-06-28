//
//  
//  TabBarRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

extension Dependency {
    static func registerTabBarScreen() {
        register(ITabBarNavigator.self) { resolver, args in
            TabBarNavigator(
                viewController: args.get()
            )
        }
        register(ITabBarPresenter.self) { resolver, args in
            TabBarPresenter(
                navigator: resolver.resolve(args: args.get("vc"))
            )
        }
        register(ITabBarViewController.self) {
            TabBarViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}
