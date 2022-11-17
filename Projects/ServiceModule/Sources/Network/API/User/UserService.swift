//
//  UserService.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/17.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import Alamofire

public enum UserService {
    case checkNickname(_ dto: UserDTO.Request.CheckNicnameRequestDTO)

}

extension UserService: TargetType {
    public var baseURL: String {
        return API.apiBaseURL
    }

    public var path: String {
        switch self {
        case .checkNickname:
            return "user/nickname/check"

        }
    }

    public var method: HTTPMethod {
        switch self {
        case .checkNickname:
            return .post

        }
    }

    public var parameters: RequestParams {
        switch self {
        case let .checkNickname(dto):
            return .body(dto)
        }
    }
}
