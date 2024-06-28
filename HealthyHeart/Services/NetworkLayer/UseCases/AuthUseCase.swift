//
//  AuthUseCase.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import Moya

extension Dependency {
    static func registerAuthUseCase() {
        register(IAuthUseCase.self) { resolver in
            AuthUseCase()
        }
    }
}

protocol IAuthUseCase {
    func refreshToken(with token: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void)
    func authUser(with phoneNumber: String, completion: @escaping (Result<SecrectKeyModel, Error>) -> Void)
    func resendPhoneCode(secretKey: String, phoneNumber: String, completion: @escaping (Result<SecrectKeyModel, Error>) -> Void)
    func verifyPhoneNumber(secretKey: String, phoneNumber: String, phoneCode: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void)
    func sendUserForm(userData: UserDateModel, completion: @escaping (Result<UserDateModel, Error>) -> Void)
}

private struct AuthUseCase: IAuthUseCase {
    
    private let provider: NetworkProvider<Target>
    
    init() {
        provider = NetworkProvider<Target>()
    }
    
    func refreshToken(with token: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void) {
        return provider.request(target: .refreshToken(token: token), completion: completion)
    }
    
    func authUser(with phoneNumber: String, completion: @escaping (Result<SecrectKeyModel, any Error>) -> Void) {
        return provider.request(target: .authUser(phoneNumber: phoneNumber), isRetryable: false, completion: completion)
    }
    
    func resendPhoneCode(secretKey: String, phoneNumber: String, completion: @escaping (Result<SecrectKeyModel, any Error>) -> Void) {
        return provider.request(target: .resendPhoneCode(secretKey: secretKey, phoneNumber: phoneNumber), isRetryable: false, completion: completion)
    }
    
    func verifyPhoneNumber(secretKey: String, phoneNumber: String, phoneCode: String, completion: @escaping (Result<TokenResponseModel, any Error>) -> Void) {
        return provider.request(target: .verifyPhoneNumber(secretKey: secretKey, phoneNumber: phoneNumber, phoneCode: phoneCode), isRetryable: false, completion: completion)
    }
    
    func sendUserForm(userData: UserDateModel, completion: @escaping (Result<UserDateModel, any Error>) -> Void) {
        return provider.request(target: .sendUserData(userData: userData), completion: completion)
    }
}

private enum Target: INetworkRouter {
    case refreshToken(token: String)
    case authUser(phoneNumber: String)
    case resendPhoneCode(secretKey: String, phoneNumber: String)
    case verifyPhoneNumber(secretKey: String, phoneNumber: String, phoneCode: String)
    case sendUserData(userData: UserDateModel)
}

extension Target: TargetType {
    var path: String {
        switch self {
        case .refreshToken:
            return "refresh/"
        case .authUser:
            return "auth_user/"
        case .resendPhoneCode:
            return "resend_phone_code/"
        case .verifyPhoneNumber:
            return "verify_phone_number/"
        case .sendUserData:
            return "user_form/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .refreshToken:
            return .post
        case .authUser:
            return .post
        case .resendPhoneCode:
            return .patch
        case .verifyPhoneNumber:
            return .patch
        case .sendUserData:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .refreshToken(let token):
            return .requestParameters(
                parameters: ["refresh": token],
                encoding: JSONEncoding.default
            )
        case .authUser(let phoneNumber):
            return .requestParameters(
                parameters: ["phone_number": phoneNumber],
                encoding: JSONEncoding.default
            )
        case .resendPhoneCode(let secretKey, let phoneNumber):
            return .requestParameters(
                parameters: [
                    "secret_key": secretKey,
                    "phone_number": phoneNumber
                ],
                encoding: JSONEncoding.default
            )
        case .verifyPhoneNumber(let secretKey, let phoneNumber, let phoneCode):
            return .requestParameters(
                parameters: [
                    "secret_key": secretKey,
                    "phone_number": phoneNumber,
                    "phone_code": phoneCode
                ],
                encoding: JSONEncoding.default
            )
        case .sendUserData(let userData):
            return .requestParameters(
                parameters: [
                    "first_name": userData.firstName,
                    "last_name": userData.lastName,
                    "date_of_birth": userData.dateOfBirth,
                    "gender": userData.male,
                    "height": userData.height,
                    "weight": userData.weight
                ],
                encoding: JSONEncoding.default
            )
        }
    }
}
