//
//  MyPageModel.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxDataSources

struct MyPageTableViewCellModel {
    var icon: UIImage
    var title: String
}

extension MyPageTableViewCellModel: Equatable {
    
    static func == (lhs: MyPageTableViewCellModel, rhs: MyPageTableViewCellModel) -> Bool {
        lhs.title == rhs.title
    }
}
