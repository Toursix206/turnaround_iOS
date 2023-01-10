//
//  ActivityRequestDTO.swift
//  ServiceModule
//
//  Created by 김인환 on 2022/12/29.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public extension ActivityDTO.Request {
    
    struct ListRequestDTO: Encodable {
        public let category: String?
        public let page: Int
        public let size: Int
        public let sort: String // 칼럼명, ASC
        public let type: String
        
        public init(
            category: String? = nil,
            page: Int = 0,
            size: Int = 100,
            sort: String,
            type: String = "FREE" // MVP 단계에서는 FREE로 지정
        ) {
            self.category = category
            self.page = page
            self.size = size
            self.sort = sort
            self.type = type
        }
        
        public init() {
            self.init(sort:
//                "BEDDING, ASC",
//                "TABLE, ASC",
//                "WASHER, ASC",
//                "KITCHEN, ASC",
//                "RESTROOM, ASC",
//                "SELF_DEVELOPMENT, ASC",
//                "ETC, ASC"
                "DESC"
            )
        }
    }
}
