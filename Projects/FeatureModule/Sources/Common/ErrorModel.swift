//
//  ErrorModel.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public struct ErrorModel {
  public init(success: Bool?, status: Int?, message: String?) {
    self.success = success
    self.status = status
    self.message = message
  }

  let success: Bool?
  let status: Int?
  let message: String?
}
