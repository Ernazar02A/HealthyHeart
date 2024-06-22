//
//  VerificationModel.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import Foundation

struct VerificationModel: Codable {
    let temporaryUserId: String
    
    enum CodingKeys: String, CodingKey {
        case temporaryUserId = "temporary_user_id"
    }
}
