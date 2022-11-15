//
//  AuthService.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import Alamofire

public enum AuthService {
  case refresh(_ dto: Token)
}

extension AuthService: TargetType {
  public var baseURL: String {
    return API.apiBaseURL
  }

  public var path: String {
    switch self {
    case .refresh:
      return "auth/refresh"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .refresh:
      return .post
    }
  }

  public var parameters: RequestParams {
    switch self {
    case let .refresh(dto):
      return .body(dto)
    }
  }
}
