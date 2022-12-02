//
//  MyPageReactor.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

import ReactorKit

import RxDataSources

typealias MyPageTableViewSectionModel = SectionModel<Void, MyPageTableViewSection>

enum MyPageTableViewSection {
    case defaultCell(MyPageTableViewCellReactor)
}

public class MyPageReactor: Reactor {
    
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    public enum CellType {
        case defaultCell(String, UIImage)
    }
    
    public var initialState = State()
    
    public enum Action {
        case viewWillAppear(String?, String?, Int?)
        case cellSelected(IndexPath)
    }
    
    public enum Mutation {
        case setNickname(String?)
        case setProfileImage(String?)
        case setPoint(Int?)
        case setSelectedIndexPath(IndexPath?)
        case setError(String?)
    }
    
    public struct State {
        var nickname: String?
        var profileImage: String?
        var point: Int?
        var error: String? = nil
        var selectedIndexPath: IndexPath?
        var sections: [MyPageTableViewSectionModel]?
    }
    
//    init(initialState: State) {
//        self.initialState = State(sections: MyPageReactor.configSections())
//    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear(let nickname, let profileImage, let point):
            provider.userRepository.checkUserInfo()
            return Observable.concat([
                Observable.just(Mutation.setNickname(nickname)),
                Observable.just(Mutation.setProfileImage(profileImage)),
                Observable.just(Mutation.setPoint(point))
            ])
                    
        case .cellSelected(let indexPath):
            return Observable.concat([
                Observable.just(Mutation.setSelectedIndexPath(indexPath)),
                Observable.just(Mutation.setSelectedIndexPath(nil))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case let .setNickname(nickname):
            newState.nickname = nickname
            
        case let .setProfileImage(profileImage):
            newState.profileImage = profileImage
            
        case let .setPoint(point):
            newState.point = point
            
        case let .setError(error):
            newState.error = error
            
        case .setSelectedIndexPath(let indexPath):
            newState.selectedIndexPath = indexPath
        }
        return newState
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let serviceMutation = provider.userRepository.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case .nickname(let nickname):
                return .just(Mutation.setNickname(nickname))
                
            case .profileType(let profileType):
                return .just(Mutation.setProfileImage(profileType))
                
            case .point(let point):
                return .just(Mutation.setPoint(point))
                
            case .sendError(let errorModel):
                guard let errorModel = errorModel else {
                    return .empty()
                }
                return .just(.setError(errorModel.message))
            }
        }
        return Observable.merge(mutation, serviceMutation)
    }
    
//    static func configSections() -> [MyPageTableViewSectionModel] {
//        var sections: [MyPageTableViewSectionModel] = []
//
//        var display: [[CellType]] = [
//            [.defaultCell("1번테스트셀", FeatureModuleAsset.ImageAsset.point.image), .defaultCell("2번테스트셀", FeatureModuleAsset.ImageAsset.point.image), .defaultCell("3번테스트셀", FeatureModuleAsset.ImageAsset.point.image)]
//        ]
//
//        for cellSection in display {
//            var section: [MyPageTableViewSection] = []
//            for item in cellSection {
//                switch item {
//                case let .defaultCell(title, image):
//                    let item: MyPageTableViewSection = .defaultCell(MyPageTableViewCellReactor(state: MyPageTableViewCellModel(title: title, image: image)))
//                    section.append(item)
//                }
//            }
//            sections.append(MyPageTableViewSectionModel(model: Void(), items: section))
//        }
//
//        return sections
//    }
    
    
}
