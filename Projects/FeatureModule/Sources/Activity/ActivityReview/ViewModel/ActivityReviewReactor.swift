//
//  ActivityReviewReactor.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/19.
//  Copyright © 2022 turnaround.io. All rights reserved.
//
import Foundation
import ReactorKit

public final class ActivityReviewReactor: Reactor {
    
    public var initialState: State = State(reviewText: "", ratingValue: 0)
    
    public enum Action {
        case changeRatingValue(Float)
        case editReviewText(String)
//        case didTapBackButton
//        case didTapCompleteButton
//        case didTapSkipButton
    }
    
    public enum Mutation {
        case setStarImage(Int)
        case setReviewText(String)
    }
    
    public struct State {
        var reviewText: String
        var ratingValue: Int
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .changeRatingValue(let float):
            return .just(.setStarImage(Int(ceil(float))))
        case .editReviewText(let text):
            return .just(.setReviewText(text))
//        case .didTapBackButton:
//            break
//        case .didTapCompleteButton:
//            break
//        case .didTapSkipButton:
//            break
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setStarImage(let ratingValue):
            newState.ratingValue = ratingValue
        case .setReviewText(let text):
            newState.reviewText = text
        }
        
        return newState
    }
}
