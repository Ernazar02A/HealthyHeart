//
//  
//  OnBoardingRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 23/6/24.
//
//

import Foundation

extension Dependency {
    static func registerOnBoardingScreen() {
        register(IOnBoardingNavigator.self) { resolver, args in
            OnBoardingNavigator(
                viewController: args.get()
            )
        }
        register(IOnBoardingPresenter.self) { resolver, args in
            OnBoardingPresenter(
                navigator: resolver.resolve(args: args.get("vc")),
                userDefaultService: resolver.resolve()
            )
        }
        register(IOnBoardingViewController.self) {
            OnBoardingViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

