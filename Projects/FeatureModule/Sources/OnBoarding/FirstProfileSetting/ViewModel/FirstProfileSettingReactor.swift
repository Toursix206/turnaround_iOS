//
//  FirstProfileSettingReactor.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import ReactorKit
import UIKit

public class FirstProfileSettingReactor: ReactorKit.Reactor {
    public enum Action {
      case viewWillAppear
    }

    public enum Mutation {
      case setCollectionViewCell([ProfileImageContent])
    }

    public struct State {
        var cellImages: [ProfileImageContent] = []
    }

    public let initialState = State()

    public func mutate(action: Action) -> Observable<Mutation> {
      switch action {
      case .viewWillAppear:
          return .just(Mutation.setCollectionViewCell(ProfileImageContent.data))
      }
    }

    public func reduce(state: State, mutation: Mutation) -> State {

      var newState = state

      switch mutation {
      case let .setCollectionViewCell(images):
          newState.cellImages = images
      }
      return newState
    }
}
