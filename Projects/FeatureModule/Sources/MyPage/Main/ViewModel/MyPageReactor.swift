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

public typealias MyPageTableViewSectionModel = SectionModel<Void, MyPageTableViewSection>

public enum MyPageTableViewSection {
    case defaultCell(MyPageTableViewCellReactor)
}

public class MyPageReactor: Reactor {
    
    public enum CellType {
        case defaultCell(String, UIImage)
    }
    
    public var initialState = State()
    
    public enum Action {
        case cellSelected(IndexPath)
    }
    
    public enum Mutation {
        case setSelectedIndexPath(IndexPath?)
    }
    
    public struct State {
        var selectedIndexPath: IndexPath?
        var sections: [MyPageTableViewSectionModel]?
    }
    
//    init(initialState: State) {
//        self.initialState = State(sections: MyPageReactor.configSections())
//    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
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
        case .setSelectedIndexPath(let indexPath):
            newState.selectedIndexPath = indexPath
        }
        return newState
    }
    
    public static func configSections() -> [MyPageTableViewSectionModel] {
        var sections: [MyPageTableViewSectionModel] = []
        
        var display: [[CellType]] = [
            [.defaultCell("1번테스트셀", FeatureModuleAsset.ImageAsset.point.image), .defaultCell("2번테스트셀", FeatureModuleAsset.ImageAsset.point.image), .defaultCell("3번테스트셀", FeatureModuleAsset.ImageAsset.point.image)]
        ]
        
        for cellSection in display {
            var section: [MyPageTableViewSection] = []
            for item in cellSection {
                switch item {
                case let .defaultCell(title, image):
                    let item: MyPageTableViewSection = .defaultCell(MyPageTableViewCellReactor(state: MyPageTableViewCellModel(icon: image, title: title)))
                    section.append(item)
                }
            }
            sections.append(MyPageTableViewSectionModel(model: Void(), items: section))
        }
        
        return sections
    }
    
    
}
