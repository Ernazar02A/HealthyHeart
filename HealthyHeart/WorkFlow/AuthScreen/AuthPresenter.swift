//
//  
//  AuthPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import Foundation

protocol IAuthDelegate: AnyObject {
    
}

protocol IAuthPresenter {
    func setDelegate(_ delegate: IAuthDelegate)
    func auth(number: String)
}

final class AuthPresenter: IAuthPresenter {
    
    private let navigator: IAuthNavigator
    weak var delegate: IAuthDelegate?
    private let authUseCase: IAuthUseCase
    
    init(
        navigator: IAuthNavigator,
        authUseCase: IAuthUseCase
    ) {
        self.navigator = navigator
        self.authUseCase = authUseCase
    }
    
    func setDelegate(_ delegate: IAuthDelegate) {
        self.delegate = delegate
    }
    
    func auth(number: String) {
        let sanitizedNumber = number.replacingOccurrences(of: " ", with: "")
        authUseCase.authUser(with: sanitizedNumber) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                navigator.showConfirmNumberScreen(
                    number: number,
                    secretKey: data
                )
            case .failure(let error):
                navigator.showNativeSingleButtonAlert(
                    title: "Что то не так",
                    message: "\(error)"
                )
            }
        }
    }
}
