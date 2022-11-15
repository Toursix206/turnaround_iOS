//
//  AuthRequestDTO.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public extension AuthDTO.Request {
    struct LoginRequestDTO: Encodable {

      public let fcmToken: String
      public let socialType: String
      // MARK: - Access Token For Auth login
      public let token: String

      public init(
        fcmToken: String,
        socialType: String,
        token: String
      ) {
        self.fcmToken = fcmToken
        self.socialType = socialType
        self.token = token
      }

    }
}
