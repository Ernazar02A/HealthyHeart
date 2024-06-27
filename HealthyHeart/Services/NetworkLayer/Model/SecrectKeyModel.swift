//
//  SecrectKeyModel.swift
//  HealthyHeart
//
//  Created by Ernazar on 25/6/24.
//

import Foundation

struct SecrectKeyModel: Codable {
    var secretKey: String
    let isCreated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case secretKey = "secret_key"
        case isCreated = "is_created"
    }
}
