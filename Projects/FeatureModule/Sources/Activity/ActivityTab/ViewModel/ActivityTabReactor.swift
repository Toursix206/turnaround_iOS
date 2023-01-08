//
//  ActivityTabViewModel.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import ReactorKit
import RxDataSources
import ServiceModule

typealias ActivityTableViewSectionModel = SectionModel<Int, ActivityTableViewSection>
typealias ActivityCategoryViewSectionModel = SectionModel<Int, ActivityCategoryCollectionViewSection>

enum ActivityTableViewSection {
    case defaultCell(ActivityListTableViewCellReactor)
}

enum ActivityCategoryCollectionViewSection {
    case defaultCell(ActivityCategoryCollectionViewCellReactor)
}

public final class ActivityTabReactor: Reactor {
    
    private let provider: ServiceProviderType
//    private let type: SignInType?
//    private let token: String?

    init(provider: ServiceProviderType) {
        self.provider = provider
//        self.type = signinType
//        self.token = oAuthToken
    }
    
    public var initialState: State = State()
    
    
    public enum Action {
        case viewWillAppear
        case selectCategory(IndexPath)
        case selectActivity(IndexPath)
    }
    
    public enum Mutation {
        case setCategory(IndexPath?)
        case setSelectedActivityIndexPath(IndexPath?)
        case setActivities([ActivityTableViewCellModel]?)
        case setLastPage(Int)
        case setNextPage(Int)
        case setError(String?)
    }
    
    public struct State {
        var selectedCategoryIndexPath: IndexPath?
        var selectedTableViewIndexPath: IndexPath?
        var categories: [ActivityCategoryCollectionViewCellModel]?
        var activities: [ActivityTableViewSectionModel]?
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            let dto = ActivityDTO.Request.ListRequestDTO()
            provider.activityRepository.getActivities(dto)
            
            return Observable.concat([
                Observable.just(.setCategory(nil)),
                Observable.just(.setSelectedActivityIndexPath(nil))
            ])
        case .selectCategory(let indexPath):
            return Observable.just(.setCategory(indexPath))
        case .selectActivity(let indexPath):
            return Observable.just(.setSelectedActivityIndexPath(indexPath))
        }
    }
    
    public func reduce(state: State, mutation: Action) -> State {
        var newState = state
        
//        switch mutation {
//        case .selectCategory(let indexPath):
////            newState.
//        case .selectActivity(let indexPath):
//        case .viewWillAppear:
//            break
//        }
        
        
        return newState
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let serviceMutation = provider.activityRepository.event.flatMap { event -> Observable<Mutation> in
            switch event {
                
            case .contents(let contents):
                let cellModels = contents.map {
                    ActivityTableViewCellModel(imageURL: URL(string: $0.imageUrl) ?? nil, title: $0.name, description: $0.description, type: $0.type)
                }
                return Observable.just(Mutation.setActivities(cellModels))
            case .activitiesLastPage(let page):
                return Observable.just(.setLastPage(page))
            case .activitiesNextPage(let page):
                return Observable.just(.setNextPage(page))
            case .sendError(let error):
                guard let error = error else { return .empty() }
                return Observable.just(.setError(error.message))
            }
        }
        return Observable.merge(mutation, serviceMutation)
    }
}
