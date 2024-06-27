//
//  
//  AuthNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import UIKit

protocol IAuthNavigator: IAlertPresentable {
    func showConfirmNumberScreen(number: String, secretKey: SecrectKeyModel)
}

struct AuthNavigator: IAuthNavigator {
    
    var viewControllerToPresentAlert: UIViewController {
        return viewController
    }
    
    weak var viewController: IAuthViewController!
    
    func showConfirmNumberScreen(number: String, secretKey: SecrectKeyModel) {
        let vc = Dependency.resolve(
            IConfirmNumberViewController.self,
            args: ["number": number, "secretKey": secretKey]
        )
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
