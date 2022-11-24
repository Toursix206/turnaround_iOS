//
//  MyPageSection.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import RxDataSources

enum MyPageSection {
    case section([MyPageSectionItem])
}

enum MyPageSectionItem {
    case customerServices(MyPageTableViewCellReactor)
    case writeReview(MyPageTableViewCellReactor)
    case settings(MyPageTableViewCellReactor)
}

extension MyPageSection: SectionModelType {
    var items: [MyPageSectionItem] {
        switch self {
        case .section(let items):
            return items
        }
    }
    
    init(original: MyPageSection, items: [MyPageSectionItem]) {
        switch original {
        case .section: self = .section(items)
        }
    }
    
}
