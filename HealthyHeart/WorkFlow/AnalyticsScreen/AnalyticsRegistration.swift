//
//  
//  AnalyticsRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

extension Dependency {
    static func registerAnalyticsScreen() {
        register(IAnalyticsNavigator.self) { resolver, args in
            AnalyticsNavigator(
                viewController: args.get()
            )
        }
        register(IAnalyticsPresenter.self) { resolver, args in
            AnalyticsPresenter(
                navigator: resolver.resolve(args: args.get("vc"))
            )
        }
        register(IAnalyticsViewController.self) {
            AnalyticsViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

