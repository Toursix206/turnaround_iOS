//
//  ActivityCategoryCollectionViewCellReactor.swift
//  FeatureModule
//
//  Created by 김인환 on 2023/01/07.
//  Copyright © 2023 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

class ActivityCategoryCollectionViewCellReactor: Reactor {
    typealias Action = NoAction
    
    var initialState: ActivityCategoryCollectionViewCellModel
    
    init(state: ActivityCategoryCollectionViewCellModel) {
        self.initialState = state
    }
}
