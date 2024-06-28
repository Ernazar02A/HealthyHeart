//
//  
//  HomeRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

extension Dependency {
    static func registerHomeScreen() {
        register(IHomeNavigator.self) { resolver, args in
            HomeNavigator(
                viewController: args.get()
            )
        }
        register(IHomePresenter.self) { resolver, args in
            HomePresenter(
                navigator: resolver.resolve(args: args.get("vc"))
            )
        }
        register(IHomeViewController.self) {
            HomeViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

