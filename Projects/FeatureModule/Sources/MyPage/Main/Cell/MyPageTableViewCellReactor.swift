//
//  MyPageTableViewCellReactor.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

public class MyPageTableViewCellReactor: Reactor {
    
    public typealias Action = NoAction
    
    public var initialState: MyPageTableViewCellModel
    
    init(state: MyPageTableViewCellModel) {
        self.initialState = state
    }
    
}
