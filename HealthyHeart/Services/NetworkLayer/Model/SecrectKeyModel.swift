//
//  SecrectKeyModel.swift
//  HealthyHeart
//
//  Created by Ernazar on 25/6/24.
//

import Foundation

struct SecrectKeyModel: Codable {
    let secretKey: String
    
    enum CodingKeys: String, CodingKey {
        case secretKey = "secret_key"
    }
}
