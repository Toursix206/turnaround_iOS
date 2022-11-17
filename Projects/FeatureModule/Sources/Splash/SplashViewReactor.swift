//
//  SplashViewReactor.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import ReactorKit
import ServiceModule

public final class SplashReactor: Reactor {

    public let initialState: State = State()
    private let provider: ServiceProviderType

    public init(provider: ServiceProviderType) {
        self.provider = provider
    }

    public enum Action {
        case viewWillAppear
    }

    public enum Mutation {
        case setIsUser(Bool)
        case setIsLoginFlow(Bool)
        case setShowAlertServerErr(String?)
    }

    public struct State {
        var isUser: Bool? = nil
        var isLoginFlow: Bool? = nil
        var showAlertServerErrMessage: String? = nil
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return refresh()
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setIsUser(isUser):
            newState.isUser = isUser
        case let .setIsLoginFlow(isLoginFlow):
            newState.isLoginFlow = isLoginFlow
        case let .setShowAlertServerErr(errMessage):
            newState.showAlertServerErrMessage = errMessage
        }
        return newState
    }
}

extension SplashReactor {
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let serviceMutation = provider.authRepository.event.flatMap { event -> Observable<Mutation> in
            switch event {

            case let .updateAccessToken(accessToken):
                Keychain.shared.setAccessToken(accessToken: accessToken)
                return .just(.setIsUser(true))

            case let .updateRefreshToken(refreshtoken):
                Keychain.shared.setRefreshToken(refreshToken: refreshtoken)
                return .empty()

            case .userId:
                return .empty()

            case let .sendError(errorModel):
                guard let errorModel = errorModel,
                      let status = errorModel.status else { return .empty() }

                if 400..<500 ~= status {
                    return .just(.setIsLoginFlow(true))
                }
                return .just(.setShowAlertServerErr(errorModel.message))
            }
        }
        return Observable.merge(mutation, serviceMutation)
    }
}

extension SplashReactor {
  private func refresh() -> Observable<Mutation> {
    let accessToken = Keychain.shared.getAccessToken() ?? ""
    let refreshToken = Keychain.shared.getRefreshToken() ?? ""

    provider.authRepository.refresh(accessToken, refreshToken)

    return .empty()
  }
}
