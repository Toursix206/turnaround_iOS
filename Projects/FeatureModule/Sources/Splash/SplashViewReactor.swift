//
//  SplashViewReactor.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import ReactorKit

final class SplashReactor: Reactor {

    let initialState: State = State()

    enum Action {
        case viewWillAppear
    }

    enum Mutation {
        case setIsLoginFlow(Bool)
    }

    struct State {
        var isLoginFlow: Bool? = nil
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return .empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setIsLoginFlow(isLoginFlow):
            newState.isLoginFlow = isLoginFlow
        }
        return newState
    }
}
