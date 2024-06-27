//
//  
//  SuccessfulLoginPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import Foundation

protocol ISuccessfulLoginDelegate: AnyObject {
    
}

protocol ISuccessfulLoginPresenter {
    func setDelegate(_ delegate: ISuccessfulLoginDelegate)
    func showInputScreen()
}

final class SuccessfulLoginPresenter: ISuccessfulLoginPresenter {
    
    private let navigator: ISuccessfulLoginNavigator
    
    weak var delegate: ISuccessfulLoginDelegate?
    
    init(navigator: ISuccessfulLoginNavigator) {
        self.navigator = navigator
    }
    
    func setDelegate(_ delegate: ISuccessfulLoginDelegate) {
        self.delegate = delegate
    }
    
    func showInputScreen() {
        navigator.pushInputScreen()
    }
}
