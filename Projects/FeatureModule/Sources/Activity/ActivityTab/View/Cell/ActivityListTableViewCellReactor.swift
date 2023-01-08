//
//  ActivityListTableViewCellReactor.swift
//  FeatureModule
//
//  Created by 김인환 on 2023/01/07.
//  Copyright © 2023 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

class ActivityListTableViewCellReactor: Reactor {
    typealias Action = NoAction
    
    let initialState: ActivityTableViewCellModel
    
    init(state: ActivityTableViewCellModel) {
        self.initialState = state
    }
}
