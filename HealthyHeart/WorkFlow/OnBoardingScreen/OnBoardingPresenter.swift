//
//  
//  OnBoardingPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 23/6/24.
//
//

import Foundation

protocol IOnBoardingDelegate: AnyObject {
    
}

protocol IOnBoardingPresenter {
    func setDelegate(_ delegate: IOnBoardingDelegate)
    func presentAuthScreen()
}

final class OnBoardingPresenter: IOnBoardingPresenter {
    
    private let navigator: IOnBoardingNavigator
    weak var delegate: IOnBoardingDelegate?
    private let userDefaultService: IUserDefaultsService
    
    init(
        navigator: IOnBoardingNavigator,
        userDefaultService: IUserDefaultsService
    ) {
        self.navigator = navigator
        self.userDefaultService = userDefaultService
        saveReadOnboarding()
    }
    
    private func saveReadOnboarding() {
        userDefaultService.setValue(
            true,
            for: .isReadOnBoarding
        )
    }
    
    func setDelegate(_ delegate: IOnBoardingDelegate) {
        self.delegate = delegate
    }
    
    func presentAuthScreen() {
        navigator.presentAuthScreen()
    }
}
