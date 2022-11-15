//
//  BaseService.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public class BaseProvider {
    unowned let provider: ServiceProviderType

    public init(provider: ServiceProviderType) {
      self.provider = provider
    }
}
