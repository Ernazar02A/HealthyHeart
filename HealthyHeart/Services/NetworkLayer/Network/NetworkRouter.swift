//
//  NetworkRouter.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import Foundation
import Moya

protocol INetworkRouter {
    typealias Parameters = [String: Any]
}

extension INetworkRouter where Self: TargetType {
    
    var baseURL: URL {
        return Dependency.resolve(IKeyChainService.self).getValue(for: .baseURL) ?? Dependency.resolve(name: .baseURL)
    }
    
    var keychainService: IKeyChainService {
        return Dependency.resolve()
    }
    
    var userDefaultsService: IUserDefaultsService {
        return Dependency.resolve()
    }
    
    var headers: [String: String]? {
        var data = ["Content-Type" : "application/json"]
        if let token = keychainService.getValue(for: .accessToken) {
            data["Authorization"] = "Bearer \(token)"
        }
        return data
    }
}
