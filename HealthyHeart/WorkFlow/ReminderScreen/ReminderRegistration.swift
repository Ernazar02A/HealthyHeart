//
//  
//  ReminderRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

extension Dependency {
    static func registerReminderScreen() {
        register(IReminderNavigator.self) { resolver, args in
            ReminderNavigator(
                viewController: args.get()
            )
        }
        register(IReminderPresenter.self) { resolver, args in
            ReminderPresenter(
                navigator: resolver.resolve(args: args.get("vc"))
            )
        }
        register(IReminderViewController.self) {
            ReminderViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

