//
//  ActivityTabViewModel.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

final class ActivityTabReactor: Reactor {
    
    var initialState: State
    
    enum Action {
        
    }
    
    struct State {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    init(initialState: State) {
        self.initialState = initialState
    }
}
