//
//  
//  UserInformationFormPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import Foundation

struct UserDateModel: Codable {
    let firstName: String
    let lastName: String
    var dateOfBirth: String
    var male: String {
        if gender == "Женщина" {
            return "W"
        } else {
            return "M"
        }
    }
    let gender: String
    let height: Int
    let weight: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case dateOfBirth = "date_of_birth"
        case gender
        case height
        case weight
    }
}

protocol IUserInformationFormDelegate: AnyObject {
    
}

protocol IUserInformationFormPresenter {
    func setDelegate(_ delegate: IUserInformationFormDelegate)
    func setDate(date: Date)
    func countinue(model: UserDateModel)
}

final class UserInformationFormPresenter: IUserInformationFormPresenter {
    
    private let navigator: IUserInformationFormNavigator
    private let authUseCase: IAuthUseCase
    weak var delegate: IUserInformationFormDelegate?
    private let locker = Locker()
    private var date: Date?
    private var userDate: UserDateModel?
    
    init(
        navigator: IUserInformationFormNavigator,
        authUseCase: IAuthUseCase
    ) {
        self.navigator = navigator
        self.authUseCase = authUseCase
    }
    
    func setDelegate(_ delegate: IUserInformationFormDelegate) {
        self.delegate = delegate
    }
    
    func setDate(date: Date) {
        self.date = date
    }
    
    func countinue(model: UserDateModel) {
        userDate = model
        guard let date else { return }
        userDate?.dateOfBirth = date.dashedDateString
        guard let userDate else { return }
        locker.lock()
        authUseCase.sendUserForm(userData: userDate) { [weak self] result in
            guard let self else { return }
            self.locker.unlock()
            switch result {
            case .success(let response):
                self.navigator.presentTabBar()
            case .failure(let error):
                self.navigator.showNativeSingleButtonAlert(
                    title: "Что то не так",
                    message: "\(error)"
                )
            }
        }
    }
}
