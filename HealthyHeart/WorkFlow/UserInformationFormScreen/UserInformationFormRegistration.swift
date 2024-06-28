//
//  
//  UserInformationFormRegistration.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import Foundation

extension Dependency {
    static func registerUserInformationFormScreen() {
        register(IUserInformationFormNavigator.self) { resolver, args in
            UserInformationFormNavigator(
                viewController: args.get()
            )
        }
        register(IUserInformationFormPresenter.self) { resolver, args in
            UserInformationFormPresenter(
                navigator: resolver.resolve(args: args.get("vc")), 
                authUseCase: resolver.resolve()
            )
        }
        register(IUserInformationFormViewController.self) {
            UserInformationFormViewController()
        }.resolveProperties { resolver, viewController, args in
            var arguments = [String: Any]()
            arguments["vc"] = viewController
            viewController.presenter = resolver.optional(args: arguments)
        }
    }
}

