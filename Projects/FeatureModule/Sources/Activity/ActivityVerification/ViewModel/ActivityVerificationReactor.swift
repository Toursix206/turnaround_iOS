//
//  ActivityVerificationViewModel.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/16.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import ReactorKit
import UIKit

public class ActivityVerificationReactor: Reactor {
    
    public var initialState: State = State(isAppearImagePickerView: false, takenImage: nil, isComplete: false, isExit: false)
    
    public enum Action {
        case didTapExit
        case didTapVerification
        case didTapRetake
        case takePhoto(UIImage?)
        case didTapComplete
    }
    
    public enum Mutation {
        case exit
        case showImagePickerView
        case setImageView(UIImage?)
        case complete
    }
    
    public struct State {
        var isAppearImagePickerView: Bool
        var takenImage: UIImage?
        var isComplete: Bool
        var isExit: Bool
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapExit:
            return .just(.exit)
        case .didTapVerification, .didTapRetake:
            return .just(.showImagePickerView)
        case .takePhoto(let image):
            return .just(.setImageView(image))
        case .didTapComplete:
            return .just(.complete)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .exit:
            newState.isExit = true
        case .showImagePickerView:
            newState.isAppearImagePickerView = true
        case .setImageView(let image):
            newState.takenImage = image
            newState.isAppearImagePickerView = false
        case .complete:
            newState.isComplete = true
        }
        return newState
    }
}
