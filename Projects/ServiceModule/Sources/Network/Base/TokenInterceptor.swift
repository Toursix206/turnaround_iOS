//
//  TokenInterceptor.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/09.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import Alamofire

internal final class TokenInterceptor: RequestInterceptor, RequestRetrier {
  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    var urlRequest = urlRequest

    let value = Keychain.shared.getAccessToken() ?? ""
    urlRequest.setValue("Bearer \(value)", forHTTPHeaderField: "Authorization")


    completion(.success(urlRequest))
  }

  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    guard
      let response = request.task?.response as? HTTPURLResponse,
      request.retryCount < 3,
      response.statusCode == 401
    else {
      return
    }
  }
}
