//
//  MyPageTableViewCellModel.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/25.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import UIKit

struct MyPageTableViewCellModel {
    var title: String
    var image: FeatureModuleImages.Image
    
    static let firstItem = MyPageTableViewCellModel(title: "고객센터 문의하기", image: FeatureModuleAsset.ImageAsset.message.image)
    static let secondItem = MyPageTableViewCellModel(title: "스토어 리뷰 남기기", image: FeatureModuleAsset.ImageAsset.thumbsUp.image)
    static let thirdItem = MyPageTableViewCellModel(title: "설정", image: FeatureModuleAsset.ImageAsset.settings.image)
    
    static let slideContents = [firstItem, secondItem, thirdItem]
}

extension MyPageTableViewCellModel: Equatable {
    
    static func == (lhs: MyPageTableViewCellModel, rhs: MyPageTableViewCellModel) -> Bool {
        lhs.title == rhs.title
    }
}


