//
//  
//  DoctorsRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

extension Dependency {
    static func registerDoctorsScreen() {
        register(IDoctorsNavigator.self) { resolver, args in
            DoctorsNavigator(
                viewController: args.get()
            )
        }
        register(IDoctorsPresenter.self) { resolver, args in
            DoctorsPresenter(
                navigator: resolver.resolve(args: args.get("vc"))
            )
        }
        register(IDoctorsViewController.self) {
            DoctorsViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

