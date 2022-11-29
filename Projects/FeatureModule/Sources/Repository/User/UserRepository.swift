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


public enum UserRepositroyEvent {
    case nickname(String)
    case point(Int)
    case profileType(String)
    case agreeAllPushNotification(Bool)
    case sendError(ErrorModel?)
}

public protocol UserRepository {
    var event: PublishSubject<UserRepositroyEvent> { get }

    func checkUserInfo()
//    func login(_ dto: AuthDTO.Request.LoginRequestDTO)
}

public final class UserRepositoryImp: BaseProvider, UserRepository {
    public var event = PublishSubject<UserRepositroyEvent>()
    
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

//    public func login(_ dto: AuthDTO.Request.LoginRequestDTO) {
//
//        NetworkService.shared.authRepository.login(dto) { [weak self] res, err in
//            guard let self = self else { return }
//            guard let data = res?.data else {
//                let errorModel = ErrorModel(
//                    success: res?.success,
//                    status: res?.status,
//                    message: res?.message
//                )
//
//                self.event.onNext(.sendError(errorModel))
//                return
//            }
//
//            self.event.onNext(.updateAccessToken(data.token.accessToken))
//            self.event.onNext(.updateRefreshToken(data.token.refreshToken))
//        }
//    }
//
//    public func refresh(_ accessToken: String, _ refreshToken: String) {
//
//        let dto = Token(accessToken: accessToken, refreshToken: refreshToken)
//
//        NetworkService.shared.authRepository.refresh(dto) { [weak self] res, err in
//            guard let self = self else { return }
//            guard let data = res?.data else {
//                let errorModel = ErrorModel(
//                    success: res?.success,
//                    status: res?.status,
//                    message: res?.message
//                )
//                self.event.onNext(.sendError(errorModel))
//                return
//            }
//
//            self.event.onNext(.updateAccessToken(data.accessToken))
//            self.event.onNext(.updateRefreshToken(data.refreshToken))
//        }
//    }
//
//    public func signup(_ dto: AuthDTO.Request.SignupRequestDTO) {
//
//        NetworkService.shared.authRepository.signup(dto) { [weak self] res, err in
//            guard let self = self else { return }
//            guard let data = res?.data else {
//                let errorModel = ErrorModel(
//                    success: res?.success,
//                    status: res?.status,
//                    message: res?.message
//                )
//
//                self.event.onNext(.sendError(errorModel))
//                return
//            }
//
//            self.event.onNext(.updateAccessToken(data.token.accessToken))
//            self.event.onNext(.updateRefreshToken(data.token.refreshToken))
//            self.event.onNext(.userId(data.userId))
//        }
//    }
}
