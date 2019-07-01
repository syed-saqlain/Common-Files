//
//  APIResponse.swift
//  Sports Friends Hookup
//
//  Created by Saqlain Syed on 19/04/2019.
//  Copyright © 2019 Saqlain Syed. All rights reserved.
//

import Foundation

struct APIResponse<T: Codable> : Codable {
    let message : String?
    let status : Bool?
    let data : T?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case data = "data"
    }
}
