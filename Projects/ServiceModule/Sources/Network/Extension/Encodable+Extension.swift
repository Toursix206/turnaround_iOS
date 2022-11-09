//
//  Encodable+Extension.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/09.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

extension Encodable {
  func toDictionary() -> [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let jsonData = try? JSONSerialization.jsonObject(with: data),
          let dictionaryData = jsonData as? [String: Any] else { return [:] }
    return dictionaryData
  }
}
