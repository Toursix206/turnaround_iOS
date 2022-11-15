//
//  AuthAPI.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

protocol AuthAPIProtocol {

  func refresh(
    _ refreshRequestDTO: Token,
    completion: @escaping (BaseResponseType<AuthDTO.Response.LoginResponseDTO>?, Error?) -> Void
  )
}

public final class AuthAPI: APIRequestLoader<AuthService>, AuthAPIProtocol {
  public func refresh(
    _ refreshRequestDTO: Token,
    completion: @escaping (BaseResponseType<AuthDTO.Response.LoginResponseDTO>?, Error?) -> Void) {
    fetchData(
      target: .refresh(refreshRequestDTO),
      responseData: BaseResponseType<AuthDTO.Response.LoginResponseDTO>.self,
      isWithInterceptor: false
    ) { res, err in
        completion(res, err)
      }
  }
}
