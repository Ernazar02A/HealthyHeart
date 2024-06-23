//
//  
//  OnBoardingNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 23/6/24.
//
//

import Foundation

protocol IOnBoardingNavigator {
    func presentAuthScreen()
}

struct OnBoardingNavigator: IOnBoardingNavigator {
    
    weak var viewController: IOnBoardingViewController!
    
    func presentAuthScreen() {
        print("presentAuthScreen")
    }
}

