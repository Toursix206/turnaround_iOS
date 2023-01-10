//
//  ActivityCategoryCollectionViewCellModel.swift
//  FeatureModule
//
//  Created by 김인환 on 2023/01/07.
//  Copyright © 2023 turnaround.io. All rights reserved.
//

import Foundation

public struct ActivityCategoryCollectionViewCellModel {
    var title: String

    static let initialModels: [Self] = ["전체", "침구류", "세탁기", "책상", "주방", "화장실", "기타가구", "자기계발"].map { Self(title: $0) }
}

extension ActivityCategoryCollectionViewCellModel: Equatable {
    public static func == (lhs: ActivityCategoryCollectionViewCellModel, rhs: ActivityCategoryCollectionViewCellModel) -> Bool {
        lhs.title == rhs.title
    }
}
