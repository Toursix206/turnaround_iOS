//
//  IntroReactor.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/07.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit
import RxSwift
import ServiceModule

import KakaoSDKUser
import KakaoSDKAuth

public class IntroReactor: Reactor {
    
    
    public enum Action {
        case tappedKakaoSignUp
        case isKakaoAvailable
        // Apple 로그인
        // case tappedAppleSignUp
        // case isAppleAvailable
    }
    
    public enum Mutation {
        case authType(AuthType)
        case authState(AuthState)
        case loginState(LoginState)
    }
    
    public struct State {
        var authType: AuthType
        var authState: AuthState
        var loginState: LoginState
    }
    
    let kakaoAuthService: AuthService
    
    public var initialState: State
    
    weak var viewController: UIViewController?
    
    init() {
        self.initialState = State(
            authType: AuthType.none,
            authState: AuthState.unAuthenticated,
            loginState: LoginState.logout
        )
        
        self.kakaoAuthService = AuthServiceManager.getKakaoAuthService()
    }
    
    func setAccessToken(accessToken: String, authType: AuthType) -> Bool {
        if accessToken == "" {
            return false
        }
        KeyChainManager.createToken(token: accessToken, key: authType.rawValue)
        return true
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tappedKakaoSignUp:
            return self.kakaoAuthService.authenticate()
                .do(
                    onSuccess: { result in print(result) },
                    onError: { error in print(error) }
                )
                .asObservable()
                .observe(on: MainScheduler.instance)
                .flatMap {
                    if $0 == AuthError.success && self.setAccessToken(
                        accessToken: self.kakaoAuthService.getAccessToken(),
                        authType: AuthType.kakao
                    ) {
                        return Single<AuthState>.just(AuthState.authenticated)
                    }
                    return Single<AuthState>.just(AuthState.unAuthenticated)
                }
                .asObservable()
                .catchAndReturn(AuthState.unAuthenticated)
                .map(Mutation.authState)
                .startWith(.authType(AuthType.kakao))
            
        case .isKakaoAvailable:
            return self.kakaoAuthService.isInstalled()
                .do(onSuccess: { result in print(result) },
                    onError: { error in print(error) }
                )
                .asObservable()
                .observe(on: MainScheduler.instance)
                .flatMap {
                    if $0 {
                        return self.kakaoAuthService.isAuthenticated()
                    }
                    return Single<AuthState>.just(AuthState.unAuthenticated)
                }
                .map {
                    if $0 == AuthState.authenticated {
                        if !self.setAccessToken(
                            accessToken: self.kakaoAuthService.getAccessToken(),
                            authType: AuthType.kakao) {
                            return AuthState.unAuthenticated
                        }
                    }
                    return $0
                }
                .asObservable()
                .catchAndReturn(AuthState.unAuthenticated)
                .map(Mutation.authState)
                .startWith(.authType(AuthType.kakao))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .authType(authType):
            state.authType = authType
            
        case let .authState(authState):
            state.authState = authState
            
        case let .loginState(loginState):
            state.loginState = loginState
        }
        
        return state
    }
}
