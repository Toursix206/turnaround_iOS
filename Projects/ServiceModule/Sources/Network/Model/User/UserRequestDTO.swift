//
//  UserRequestDTO.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/17.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public extension UserDTO.Request {
    
    struct CheckNicnameRequestDTO: Encodable {

        public let nickname: String

        public init(
            nickname: String
        ) {
            self.nickname = nickname
        }
    }
}
