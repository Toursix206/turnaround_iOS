//
//  SignInType.swift
//  ServiceModuleTests
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

enum SignInType: CustomStringConvertible {
    case Apple
    case Kakao

    var description: String {

        switch self {
        case .Apple: return "APPLE"
        case .Kakao: return "KAKAO"
        }
    }
}
