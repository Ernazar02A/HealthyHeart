//
//  ConfirmCodeResponseModel.swift
//  HealthyHeart
//
//  Created by Ernazar on 25/6/24.
//

import Foundation

struct ConfirmCodeResponseModel: Codable {
    let isCreate: Bool
    
    enum CodingKeys: String, CodingKey {
        case isCreate = "is_create"
    }
}
