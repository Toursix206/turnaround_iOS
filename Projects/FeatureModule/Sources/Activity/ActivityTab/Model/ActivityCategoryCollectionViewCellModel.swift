//
//  ActivityCategoryCollectionViewCellModel.swift
//  FeatureModule
//
//  Created by 김인환 on 2023/01/07.
//  Copyright © 2023 turnaround.io. All rights reserved.
//

import Foundation

struct ActivityCategoryCollectionViewCellModel {
    var imageURL: URL?
    var title: String
}

extension ActivityCategoryCollectionViewCellModel: Equatable {
    static func == (lhs: ActivityCategoryCollectionViewCellModel, rhs: ActivityCategoryCollectionViewCellModel) -> Bool {
        lhs.title == rhs.title
    }
}
