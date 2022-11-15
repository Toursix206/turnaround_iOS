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
        case didTapKakao
    }
    
    public enum Mutation {
        case setExample
    }
    
    public struct State {
        var example: String = ""
    }
    
    public var initialState: State = State()
    
    weak var viewController: UIViewController?
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapKakao:
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setExample:
            newState.example = ""
        }
        
        return state
    }
}
