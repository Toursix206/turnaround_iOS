//
//  OAuthable.swift
//  ServiceModuleTests
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public typealias Success = ((String, String?) -> ())
public typealias Failure = ((Error) -> ())

public protocol OAuthable {
    func login()
    var onSuccess: Success? { get set }
    var onFailure: Failure? { get set }
}
