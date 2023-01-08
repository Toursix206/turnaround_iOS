//
//  ActivityResponseDTO.swift
//  ServiceModule
//
//  Created by 김인환 on 2022/12/29.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public extension ActivityDTO.Response {
    
    struct ActivitiesResponseDTO: Decodable {

        public let contents: [Contents]
        public let lastPage: Int
        public let nextPage: Int

        enum CodingKeys: String, CodingKey {
            case contents, lastPage, nextPage
        }
    }
    
    struct Contents: Decodable {
        
        public let activityId: Int
        public let broom: Int
        public let category: String
        public let description: String
        public let duration: Int
        public let imageUrl: String
        public let name: String
        public let type: String
        
        enum CodingKeys: String, CodingKey {
            case activityId, broom, category, description, duration, imageUrl, name, type
        }
    }
}

//{
//  "data": {
//    "contents": [
//      {
//        "activityId": 0,
//        "broom": 0,
//        "category": "BEDDING",
//        "description": "string",
//        "duration": 0,
//        "imageUrl": "string",
//        "name": "string",
//        "type": "FREE"
//      }
//    ],
//    "lastPage": 0,
//    "nextPage": 0
//  },
//  "message": "string",
//  "status": 0,
//  "success": true
//}
