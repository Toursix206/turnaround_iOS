//
//  ActivityAPI.swift
//  ServiceModule
//
//  Created by 김인환 on 2022/12/29.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

protocol ActivityAPIProtocol {
    func getActivityList(
        _ activityListRequestDTO: ActivityDTO.Request.ListRequestDTO,
        completion: @escaping (BaseResponseType<ActivityDTO.Response.ActivitiesResponseDTO>?, Error?) -> Void
    )
}

public final class ActivityAPI: APIRequestLoader<ActivityService>, ActivityAPIProtocol {
    public func getActivityList(
        _ activityListRequestDTO: ActivityDTO.Request.ListRequestDTO,
        completion: @escaping (BaseResponseType<ActivityDTO.Response.ActivitiesResponseDTO>?, Error?) -> Void) {
        fetchData(
            target: .getActivities(activityListRequestDTO),
            responseData: BaseResponseType<ActivityDTO.Response.ActivitiesResponseDTO>.self,
            isWithInterceptor: false
        ) { res, err in
            completion(res, err)
        }
    }
}
