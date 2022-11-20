//
//  ProfileImageContent.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

public struct ProfileImageContent: Equatable {
    let image: UIImage
}

extension ProfileImageContent {
    static var data: [ProfileImageContent] = [
        ProfileImageContent(image: FeatureModuleAsset.ImageAsset.memoji.image),
        ProfileImageContent(image: FeatureModuleAsset.ImageAsset.memoji2.image),
        ProfileImageContent(image: FeatureModuleAsset.ImageAsset.memoji3.image)
    ]
}
