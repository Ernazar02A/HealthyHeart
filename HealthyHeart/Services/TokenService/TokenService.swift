//
//  TokenService.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import Foundation
import Moya

final class TokenService {
    
    static let shared = TokenService()
    
    private let keychainService = Dependency.resolve(IKeyChainService.self)
    private let authUseCase = Dependency.resolve(IAuthUseCase.self)
    private var savedRequests: [DispatchWorkItem] = []
    private(set) var nowIsUpdatingToken = false
    
    private init() { }
    
    func refreshToken(with oldToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let sessionToken = keychainService.getValue(for: .accessToken)
        let refreshToken = keychainService.getValue(for: .refreshToken)
        
        if let sessionToken, let refreshToken {
            if sessionToken == oldToken {
                if !nowIsUpdatingToken{
                    nowIsUpdatingToken = true
                    authUseCase.refreshToken(with: refreshToken) { [weak self] result in
                        guard let self else { return }
                        nowIsUpdatingToken = false
                        switch result {
                        case .success(let model):
                            saveToken(with: model)
                            completion(.success(()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            } else {
                nowIsUpdatingToken = false
                completion(.success(()))
            }
        } else {
            removeAllRequest()
            completion(.failure(MoyaError.statusCode(Response(statusCode: 401, data: Data()))))
        }
    }
    
    func saveToken(with model: TokenResponseModel) {
        keychainService.setValue(model.accessToken, for: .accessToken)
        keychainService.setValue(model.refreshToken, for: .refreshToken)
    }
    
    func saveTokenRegisterScreen(with token: String) {
        keychainService.setValue(token, for: .accessToken)
    }
    
    func saveVerificationToken(with token: VerificationModel) {
        keychainService.setValue(token.temporaryUserId, for: .verificationToken)
    }
    
    func saveRequest(_ block: @escaping () -> Void) {
        savedRequests.append(DispatchWorkItem {
            block()
        })
    }
    
    func executeAllSavedRequests() {
        savedRequests.forEach { DispatchQueue.global().async(execute: $0) }
        savedRequests.removeAll()
    }
    
    func removeAllRequest() {
        savedRequests.removeAll()
    }
}
