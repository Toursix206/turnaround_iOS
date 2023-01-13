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
    
    var englishTitle: String {
        Self.englishTitleDict[title] ?? ""
    }
    
    private var unselectedImageTitle: String {
        Self.imageTitleDict[title] ?? "category_all"
    }
    
    private var selectedImageTitle: String {
        "\(Self.imageTitleDict[title] ?? "category_all")_selected"
    }
    
    var isSelected: Bool = false
    
    var imageTitle: String {
        isSelected ? selectedImageTitle : unselectedImageTitle
    }

    static let initialModels: [Self] = ["전체", "침구류", "세탁기", "책상", "주방", "화장실", "기타가구", "자기계발"].map { Self(title: $0) }
    
    static let englishTitleDict = ["전체": "",
                                   "침구류": "BEDDING",
                                   "책상": "TABLE",
                                   "세탁기": "WASHER",
                                   "주방": "KITCHEN",
                                   "화장실": "RESTROOM",
                                   "자기계발": "SELF_DEVELOPMENT",
                                   "기타가구": "ETC"]
    
    static let imageTitleDict = ["전체": "category_all",
                                 "침구류": "category_bed",
                                 "책상": "category_desk",
                                 "세탁기": "category_washing machine",
                                 "주방": "category_kitchen",
                                 "화장실": "category_bathroom",
                                 "자기계발": "category_self-improvement",
                                 "기타가구": "category_household"]
}

extension ActivityCategoryCollectionViewCellModel: Equatable {
    public static func == (lhs: ActivityCategoryCollectionViewCellModel, rhs: ActivityCategoryCollectionViewCellModel) -> Bool {
        lhs.title == rhs.title
    }
}
