//
//  AuthRepository.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import ServiceModule
import RxSwift
import RxCocoa


public enum AuthRepositroyEvent {
    case updateAccessToken(String)
    case updateRefreshToken(String)
    case sendError(ErrorModel?)
}

public protocol AuthRepository {
    var event: PublishSubject<AuthRepositroyEvent> { get }

    func login(_ dto: AuthDTO.Request.LoginRequestDTO)
    func refresh(_ accessToken: String, _ refreshToken: String)
}

public final class AuthRepositoryImp: BaseProvider, AuthRepository {
    public var event = PublishSubject<AuthRepositroyEvent>()

    public func login(_ dto: AuthDTO.Request.LoginRequestDTO) {

        NetworkService.shared.authRepository.login(dto) { [weak self] res, err in
            guard let self = self else { return }
            guard let data = res?.data else {
                let errorModel = ErrorModel(
                    success: res?.success,
                    status: res?.status,
                    message: res?.message
                )

                self.event.onNext(.sendError(errorModel))
                return
            }

            self.event.onNext(.updateAccessToken(data.token.accessToken))
            self.event.onNext(.updateRefreshToken(data.token.refreshToken))
        }
    }

    public func refresh(_ accessToken: String, _ refreshToken: String) {

        let dto = Token(accessToken: accessToken, refreshToken: refreshToken)

        NetworkService.shared.authRepository.refresh(dto) { [weak self] res, err in
            guard let self = self else { return }
            guard let data = res?.data else {
                let errorModel = ErrorModel(
                    success: res?.success,
                    status: res?.status,
                    message: res?.message
                )
                self.event.onNext(.sendError(errorModel))
                return
            }

            self.event.onNext(.updateAccessToken(data.token.accessToken))
            self.event.onNext(.updateRefreshToken(data.token.refreshToken))
        }
    }
}
