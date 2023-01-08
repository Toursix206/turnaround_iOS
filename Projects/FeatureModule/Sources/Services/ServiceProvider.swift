//
//  ServiceProvider.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import ServiceModule

public protocol ServiceProviderType: AnyObject {
    var authRepository: AuthRepository { get }
    var userRepository: UserRepository { get }
    
    // Activity
    var activityRepository: ActivityRepository { get }
}
public final class ServiceProvider: ServiceProviderType {
    public init() { }
    lazy public var authRepository: AuthRepository = AuthRepositoryImp(provider: self)
    lazy public var userRepository: UserRepository = UserRepositoryImp(provider: self)
    
    lazy public var activityRepository: ActivityRepository = ActivityRepositoryImpl(provider: self)
}
