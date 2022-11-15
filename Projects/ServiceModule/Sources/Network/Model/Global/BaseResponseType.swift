//
//  BaseResponseType.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public struct BaseResponseType<T: Decodable>: Decodable {

  public let status: Int
  public let success: Bool
  public let message: String
  public let data: T?
}

public struct BaseErrorResponseType: Decodable {
  public let status: Int
  public let message: String
  public let name: String
}
