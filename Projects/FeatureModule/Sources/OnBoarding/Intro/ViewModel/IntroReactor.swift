//
//  IntroReactor.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/07.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import ReactorKit
import ServiceModule

public class IntroReactor: Reactor {

    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
    }

    public enum Action {
        case didTapSignIn(SignInType)
        case login(oAuthToken: String?, error: Error?)
        case initial
    }
    
    public enum Mutation {
        case setOAuthToken(String?)
        case setSignInType(SignInType?)
        case setError(String?)
        case setEnterInfoFlag(Bool?)
        case setEnterTabBarFlag(Bool?)
        case setInitial
    }
    
    public struct State {
        var oauthToken: String?
        var signInType: SignInType?
        var error: String? = nil
        var enterInfoFlag: Bool?
        var enterTabBarFlag: Bool?
    }
    
    public var initialState: State = State()
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .didTapSignIn(signInType):
            return .just(.setSignInType(signInType))

        case .login(oAuthToken: let oAuthToken, error: let error):

            if let error = error {
                return .just(.setError(error.localizedDescription))
            }

            guard let oAuthToken = oAuthToken,
                  let signInType = currentState.signInType else {
                return .empty()
            }

            let loginRequestDTO = AuthDTO.Request.LoginRequestDTO(
                fcmToken: Keychain.shared.getFCMToken() ?? "",
                socialType: signInType.description,
                token: oAuthToken)

            provider.authRepository.login(loginRequestDTO)

            return .just(.setOAuthToken(oAuthToken))

        case .initial:
            return .just(.setInitial)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {

        case let .setOAuthToken(oauthToken):
            newState.oauthToken = oauthToken

        case let .setSignInType(signInType):
            newState.signInType = signInType

        case let .setError(err):
            newState.error = err

        case let .setEnterInfoFlag(flag):
            newState.enterInfoFlag = flag

        case let .setEnterTabBarFlag(flag):
            newState.enterTabBarFlag = flag

        case .setInitial:
            newState = initialState
        }
        return newState
    }

    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let serviceMutation = provider.authRepository.event.flatMap { event -> Observable<Mutation> in

            switch event {

            case .updateAccessToken(let accessToken):
                Keychain.shared.setAccessToken(accessToken: accessToken)
                return .just(.setEnterTabBarFlag(true))

            case .updateRefreshToken(let refreshToken):
                Keychain.shared.setRefreshToken(refreshToken: refreshToken)
                return .empty()

            case .userId:
                return .empty()

            case .sendError(let errorModel):
                guard
                    let errorModel = errorModel,
                    let statusCode = errorModel.status
                else {
                    return .empty()
                }

                if statusCode == 404 {
                    return .just(.setEnterInfoFlag(true))
                }

                return .just(.setError(errorModel.message))
            }
        }
        return Observable.merge(mutation, serviceMutation)
    }
}
