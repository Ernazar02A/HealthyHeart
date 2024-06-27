//
//  
//  ConfirmNumberPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import Foundation

protocol IConfirmNumberDelegate: AnyObject {
    func setNumber(number: String)
    func showErrorCode()
    func reStartTimer()
}

protocol IConfirmNumberPresenter {
    func setDelegate(_ delegate: IConfirmNumberDelegate)
    func confirmCode(code: String)
    func resendCode()
}

final class ConfirmNumberPresenter: IConfirmNumberPresenter {
    
    private let navigator: IConfirmNumberNavigator
    weak var delegate: IConfirmNumberDelegate?
    private let authUseCase: IAuthUseCase
    private let locker = Locker()
    private let number: String
    private var secretKey: SecrectKeyModel
    init(
        navigator: IConfirmNumberNavigator,
        authUseCase: IAuthUseCase,
        number: String,
        secretKey: SecrectKeyModel
    ) {
        self.navigator = navigator
        self.authUseCase = authUseCase
        self.number = number
        self.secretKey = secretKey
    }
    
    func setDelegate(_ delegate: IConfirmNumberDelegate) {
        self.delegate = delegate
        delegate.setNumber(number: number)
    }
    
    func confirmCode(code: String) {
        let sanitizedNumber = number.replacingOccurrences(of: " ", with: "")
        locker.lock()
        authUseCase.verifyPhoneNumber(
            secretKey: secretKey.secretKey,
            phoneNumber: sanitizedNumber,
            phoneCode: code
        ) { [weak self] result in
            guard let self else { return }
            self.locker.unlock()
            switch result {
            case .success(let data):
                TokenService.shared.saveToken(with: data)
                if let isCreate = secretKey.isCreated, isCreate {
                    navigator.presentSuccessVerificationScreen()
                } else {
                    navigator.presentTabBarScreen()
                }
            case .failure(let failure as NSError):
                if failure.code == 400 {
                    self.delegate?.showErrorCode()
                } else {
                    self.navigator.showNativeSingleButtonAlert(
                        title: "Что то пошло не так",
                        message: failure.localizedDescription
                    )
                }
            }
        }
    }
    
    func resendCode() {
        let sanitizedNumber = number.replacingOccurrences(of: " ", with: "")
        locker.lock()
        authUseCase.resendPhoneCode(
            secretKey: secretKey.secretKey,
            phoneNumber: sanitizedNumber
        ) { [weak self] result in
            guard let self else { return }
            self.locker.unlock()
            switch result {
            case .success(let data):
                self.secretKey.secretKey = data.secretKey
                self.delegate?.reStartTimer()
            case .failure(let failure as NSError):
                self.navigator.showNativeSingleButtonAlert(
                    title: "Что то пошло не так",
                    message: failure.localizedDescription
                )
            }
        }
    }
}
