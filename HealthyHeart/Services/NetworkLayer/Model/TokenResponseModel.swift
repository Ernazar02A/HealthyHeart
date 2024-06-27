//
//  TokenResponseModel.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 10/6/24.
//

import Foundation

struct TokenResponseModel: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
    }
}
