//
//  ActivityTableViewCellModel.swift
//  FeatureModule
//
//  Created by 김인환 on 2023/01/07.
//  Copyright © 2023 turnaround.io. All rights reserved.
//

import Foundation

public struct ActivityTableViewCellModel {
    var imageURL: URL?
    var title: String
    var description: String
    var type : String
}

extension ActivityTableViewCellModel: Equatable {
    public static func == (lhs: ActivityTableViewCellModel, rhs: ActivityTableViewCellModel) -> Bool {
        lhs.title == rhs.title
    }
}
