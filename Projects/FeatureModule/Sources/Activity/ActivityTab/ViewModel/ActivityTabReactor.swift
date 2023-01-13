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

typealias ActivityCategoryViewSectionModel = SectionModel<Int, ActivityCategoryCollectionViewSection>
typealias ActivityTableViewSectionModel = AnimatableSectionModel<String, ActivityTableViewSection>

enum ActivityCategoryCollectionViewSection {
    case defaultCell(ActivityCategoryCollectionViewCellReactor)
}

enum ActivityTableViewSection {
    case defaultCell(ActivityListTableViewCellReactor)
}

extension ActivityTableViewSection: Equatable, IdentifiableType {
    static func == (lhs: ActivityTableViewSection, rhs: ActivityTableViewSection) -> Bool {
        if case.defaultCell(let lhsCellReactor) = lhs, case.defaultCell(let rhsCellReactor) = rhs {
            return lhsCellReactor.currentState.title == rhsCellReactor.currentState.title
        } else {
            return false
        }
    }
    
    typealias Identity = String
    
    var identity: String {
        if case .defaultCell(let activityListTableViewCellReactor) = self {
            return activityListTableViewCellReactor.currentState.title
        } else {
            return "".hashValue.formatted()
        }
    }
}

public final class ActivityTabReactor: Reactor {
    
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    public var initialState: State = State()
    
    
    public enum Action {
        case viewWillAppear
        case selectCategory(IndexPath)
        case selectActivity(IndexPath)
    }
    
    public enum Mutation {
        case setSelectedCategoryIndexPath(IndexPath?)
        case setSelectedActivityIndexPath(IndexPath?)
        case setCategories([ActivityCategoryCollectionViewCellModel]?)
        case setActivities([ActivityTableViewCellModel]?)
        case setLastPage(Int)
        case setNextPage(Int)
        case setError(String?)
    }
    
    public struct State {
        var selectedCategoryIndexPath: IndexPath?
        var selectedTableViewIndexPath: IndexPath?
        var categories: [ActivityCategoryViewSectionModel]?
        var activities: [ActivityTableViewSectionModel]?
        var lastPage: Int?
        var nextPage: Int?
        var errorMessage: String?
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            let dto = ActivityDTO.Request.ListRequestDTO()
            provider.activityRepository.getActivities(dto)

            return Observable.concat([
                Observable.just(.setCategories(ActivityCategoryCollectionViewCellModel.initialModels)),
                Observable.just(.setSelectedCategoryIndexPath(nil)),
                Observable.just(.setSelectedActivityIndexPath(nil)),
            ])
        case .selectCategory(let indexPath):
            guard let categories = currentState.categories else { return .empty() }
            switch categories[0].items[indexPath.row] {
            case .defaultCell(let reactor):
                let dto = ActivityDTO.Request.ListRequestDTO(category: reactor.currentState.englishTitle,
                                                             page: 0,
                                                             size: 100,
                                                             sort: "DESC")
                provider.activityRepository.getActivities(dto)
            }
            return Observable.just(.setSelectedCategoryIndexPath(indexPath))
        case .selectActivity(let indexPath):
            return Observable.just(.setSelectedActivityIndexPath(indexPath))
        }
    }
    
    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> { // 네트워킹 작업 처리
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
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setActivities(let cellModels):
            guard let cellModels = cellModels else { return newState }
            let cellReactors = cellModels.compactMap { ActivityTableViewSection.defaultCell(ActivityListTableViewCellReactor(state: $0))  }
            let sectionModel = ActivityTableViewSectionModel(model: "", items: cellReactors)
            newState.activities = [sectionModel]
        case .setSelectedCategoryIndexPath(let indexPath):
            guard let indexPath = indexPath, let categories = state.categories?[0] else { return newState }
            
            for i in 0..<categories.items.count {
                switch newState.categories?[0].items[i] {
                case .defaultCell(let reactor):
                    var cellModel = reactor.currentState
                    cellModel.isSelected = i == indexPath.row ? true : false
                    newState.categories?[0].items[i] = .defaultCell(ActivityCategoryCollectionViewCellReactor(state: cellModel))
                case .none:
                    return newState
                }
            }
            newState.selectedCategoryIndexPath = indexPath
        case .setSelectedActivityIndexPath(let indexPath):
            newState.selectedTableViewIndexPath = indexPath
        case .setLastPage(let page):
            newState.lastPage = page
        case .setNextPage(let page):
            newState.nextPage = page
        case .setError(let errorMessage):
            newState.errorMessage = errorMessage
        case .setCategories(let cellModels):
            guard let cellModels = cellModels else { return newState }
            let cellReactors = cellModels.compactMap { ActivityCategoryCollectionViewSection.defaultCell(ActivityCategoryCollectionViewCellReactor(state: $0)) }
            let sectionModel = ActivityCategoryViewSectionModel(model: 0, items: cellReactors)
            newState.categories = [sectionModel]
        }
        
        return newState
    }
}
