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
    func login(with email: String, password: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void)
    func register(with email: String, password: String, confirmPassword: String, completion: @escaping (Result<EmailModel, Error>) -> Void)
    func googleAuth(with idToken: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void)
    func confirmEmailCode(with code: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void)
    func forgotPassword(with email: String, completion: @escaping (Result<String, Error>) -> Void)
}

private struct AuthUseCase: IAuthUseCase {
    
    private let provider: NetworkProvider<Target>
    
    init() {
        provider = NetworkProvider<Target>()
    }
    
    func login(with email: String, password: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void) {
        return provider.request(target: .login(email: email, password: password), isRetryable: false, completion: completion)
    }
    
    func googleAuth(with idToken: String, completion: @escaping (Result<TokenResponseModel, any Error>) -> Void) {
        return provider.request(target: .googleAuth(idToken: idToken), completion: completion)
    }
    
    func refreshToken(with token: String, completion: @escaping (Result<TokenResponseModel, Error>) -> Void) {
        return provider.request(target: .refreshToken(token: token), completion: completion)
    }
    
    func register(with email: String, password: String, confirmPassword: String, completion: @escaping (Result<EmailModel, any Error>) -> Void) {
        return provider.request(target: .register(email: email, password: password, confirmPassword: confirmPassword), isRetryable: false, completion: completion)
    }
    
    func confirmEmailCode(with code: String, completion: @escaping (Result<TokenResponseModel, any Error>) -> Void) {
        return provider.request(target: .confirmEmailCode(code: code), isRetryable: false, completion: completion)
    }
    
    func forgotPassword(with email: String, completion: @escaping (Result<String, any Error>) -> Void) {
        return provider.request(target: .forgotPassword(email: email), isRetryable: false, completion: completion)
    }
}

private enum Target: INetworkRouter {
    case refreshToken(token: String)
    case googleAuth(idToken: String)
    case login(email: String, password: String)
    case register(email: String, password: String, confirmPassword: String)
    case confirmEmailCode(code: String)
    case forgotPassword(email: String)
}

extension Target: TargetType {
    var path: String {
        switch self {
        case .login:
            return "login/"
        case .refreshToken:
            return "users/refresh/"
        case .googleAuth:
            return "google-auth/"
        case .register:
            return "register/"
        case .confirmEmailCode(let code):
            return "user/\(code)"
        case .forgotPassword:
            return "forgot-password/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .refreshToken:
            return .post
        case .googleAuth:
            return .post
        case .register:
            return .post
        case .confirmEmailCode:
            return .get
        case .forgotPassword:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )
        case .refreshToken(let oldToken):
            return .requestParameters(
                parameters: ["refresh": oldToken],
                encoding: JSONEncoding.default
            )
        case .googleAuth(let idToken):
            return .requestParameters(
                parameters: ["auth_token": idToken],
                encoding: JSONEncoding.default
            )
        case .register(let email, let password, let confirmPassword):
            return .requestParameters(
                parameters: ["email": email, "password": password, "password_submit": confirmPassword],
                encoding: JSONEncoding.default
            )
        case .confirmEmailCode:
            return .requestPlain
        case .forgotPassword(let email):
            return .requestParameters(
                parameters: ["email": email],
                encoding: JSONEncoding.default
            )
        }
    }
}
