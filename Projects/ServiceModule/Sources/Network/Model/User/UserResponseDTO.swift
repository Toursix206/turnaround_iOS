//
//  UserResponseDTO.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/17.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public extension UserDTO.Response {

    struct CheckUserInfoResponseDTO: Decodable {

        public let nickname: String
        public let point: Int
        public let profileType: String

        enum CodingKeys: String, CodingKey {
            case nickname
            case point
            case profileType
        }
    }
}
