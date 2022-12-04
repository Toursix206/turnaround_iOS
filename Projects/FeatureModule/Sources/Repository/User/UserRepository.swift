//
//  UserRepository.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/28.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import ServiceModule
import RxSwift
import RxCocoa


public enum UserRepositoryEvent {
    case nickname(String)
    case point(Int)
    case profileType(String)
    case sendError(ErrorModel?)
}

public protocol UserRepository {
    var event: PublishSubject<UserRepositoryEvent> { get }

    func checkUserInfo()
}

public final class UserRepositoryImp: BaseProvider, UserRepository {
    public var event = PublishSubject<UserRepositoryEvent>()
    
    public func checkUserInfo() {
        NetworkService.shared.userRepository.checkUserInfo { [weak self] result, error in
            guard let self = self else { return }
            guard let data = result?.data else {
                let errorModel = ErrorModel(
                    success: result?.success,
                    status: result?.status,
                    message: result?.message
                )
                self.event.onNext(.sendError(errorModel))
                return
            }
            
            self.event.onNext(.nickname(data.nickname))
            self.event.onNext(.point(data.point))
            self.event.onNext(.profileType(data.profileType))
        }
    }
    
}
