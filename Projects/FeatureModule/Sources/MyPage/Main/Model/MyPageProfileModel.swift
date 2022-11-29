//
//  MyPageProfileModel.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/28.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

public struct MyPageProfileModel: Equatable {
    let nickname: String
    let profileImage: String
    let point: Int
}

extension MyPageProfileModel {
    static var data: [MyPageProfileModel] = [
        MyPageProfileModel(nickname: "투오식스", profileImage: "ONE", point: 1000)
    ]
}
