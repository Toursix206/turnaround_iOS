//
//  ActivityStepReactor.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

final public class ActivityStepReactor: Reactor {
    public let initialState: State = State(currentStep: .one, isAppearCancelPopUp: false, isActivityCancel: false)
    
    public enum Action {
        case didTapComplete
        case didTapCancel
        case didTapPopUpCancel
        case didTapPopUpOK
    }
    
    public enum Mutation {
        case gotoNextStep
        case setAppearCancelPopUp(Bool)
        case activityCancel
    }
    
    public struct State {
        var currentStep: Step
        var isAppearCancelPopUp: Bool
        var isActivityCancel: Bool
        
        var stepLabelText: String {
            switch currentStep {
            case .one:
                return "STEP 01"
            case .two:
                return "STEP 02"
            case .three:
                return "STEP 03"
            case .four:
                return "STEP 04"
            }
        }
        
        var titleText: String {
            switch currentStep {
            case .one:
                return "책상위 잡동사니를 모두 꺼내요."
            case .two:
                return "책상위 물티슈를 이용해 빠르게 닦아요."
            case .three:
                return "잡동사니를 버릴 것과\n사용할 것으로 분류해요."
            case .four:
                return "분류한 대로 수납장에 버릴 것은\n당장 쓰레기 통으로!"
            }
        }
        
        var subtitleText: String {
            switch currentStep {
            case .one:
                return "이때 바구니를 준비해서 한곳에 담아놓기."
            case .two:
                return "미리 배달용기, 플라스틱 물병, 큰 쓰레기\n부터 치우면 좋아요!"
            case .three:
                return "이때 안쓰는 사무용품은 주저하지 말고 버리기!"
            case .four:
                return "다양한 수납 아이템을 사용하면 효율 UP!"
            }
        }
        
        var progressRatio: Float {
            return Float(0.25 * Double(currentStep.rawValue))
        }
        
        var image: UIImage {
            switch currentStep {
            case .one:
                return FeatureModuleAsset.ImageAsset.step1Image.image
            case .two:
                return FeatureModuleAsset.ImageAsset.step2Image.image
            case .three:
                return FeatureModuleAsset.ImageAsset.step3Image.image
            case .four:
                return FeatureModuleAsset.ImageAsset.step4Image.image
            }
        }
        
        var buttonText: String {
            switch currentStep {
            case .one:
                return "1단계 완료"
            case .two:
                return "2단계 완료"
            case .three:
                return "3단계 완료"
            case .four:
                return "마지막 4단계도 완료!"
            }
        }
        
        enum Step: Int {
            case one = 1, two, three, four
            
            mutating func next() {
                self = Step(rawValue: rawValue + 1) ?? .four
            }
        }
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapComplete:
            return Observable.just(Mutation.gotoNextStep)
        case .didTapCancel:
            return Observable.just(Mutation.setAppearCancelPopUp(true))
        case .didTapPopUpCancel:
            return Observable.just(Mutation.setAppearCancelPopUp(false))
        case .didTapPopUpOK:
            return Observable.just(Mutation.activityCancel)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .gotoNextStep:
            newState.currentStep.next()
        case .setAppearCancelPopUp(let isAppear):
            newState.isAppearCancelPopUp = isAppear
        case .activityCancel:
            newState.isActivityCancel = true
        }
        
        return newState
    }
}
