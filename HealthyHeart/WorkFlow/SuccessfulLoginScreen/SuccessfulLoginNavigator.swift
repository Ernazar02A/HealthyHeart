//
//  
//  SuccessfulLoginNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import Foundation

protocol ISuccessfulLoginNavigator {
    func pushInputScreen()
}

struct SuccessfulLoginNavigator: ISuccessfulLoginNavigator {
    
    weak var viewController: ISuccessfulLoginViewController!
    
    func pushInputScreen() {
        print("pushInputScreen")
    }
}

