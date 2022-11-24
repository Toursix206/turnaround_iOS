//
//  MyPageTableViewCellReactor.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

class MyPageTableViewCellReactor: Reactor {
    
    typealias Action = NoAction
    
    var initialState: MyPageTableViewCellModel
    
    init(state: MyPageTableViewCellModel) {
        self.initialState = state
    }
    
}
