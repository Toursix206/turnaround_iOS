//
//  AuthResponseDTO.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public extension AuthDTO.Response {

    struct LoginResponseDTO: Decodable {

        public let token: Token
        public let isJoiningRoom: Bool

        enum CodingKeys: String, CodingKey {
            case token
            case isJoiningRoom
        }
    }

    struct SignupResponseDTO: Decodable {

        public let token: Token
        public let userId: Int

        enum CodingKeys: String, CodingKey {
            case token
            case userId
        }
    }
}
