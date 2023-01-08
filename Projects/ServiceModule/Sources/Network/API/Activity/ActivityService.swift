//
//  ActivityService.swift
//  ServiceModule
//
//  Created by 김인환 on 2022/12/29.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import Alamofire

public enum ActivityService {
    case getActivities(_ dto: ActivityDTO.Request.ListRequestDTO)
}

extension ActivityService: TargetType {
    public var baseURL: String {
        return API.apiBaseURL
    }
    
    public var path: String {
        switch self {
        case .getActivities:
            return "activities"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getActivities:
            return .get
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case let .getActivities(dto):
            return .query(dto)
        }
    }
}
