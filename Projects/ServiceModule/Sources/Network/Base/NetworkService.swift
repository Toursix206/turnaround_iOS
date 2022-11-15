//
//  NetworkService.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/09.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

final public class NetworkService {
  public static var shared = NetworkService()

  private init() { }

  public let authRepository = AuthAPI(isLogging: true)
}
