//
//  ActivityRepository.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/29.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import ServiceModule
import RxSwift
import RxCocoa

public enum ActivityRepositoryEvent {
    case contents([ActivityDTO.Response.Contents])
    case activitiesLastPage(Int)
    case activitiesNextPage(Int)
    case sendError(ErrorModel?)
}

public protocol ActivityRepository {
    var event: PublishSubject<ActivityRepositoryEvent> { get }
    
    func getActivities(_ dto: ActivityDTO.Request.ListRequestDTO)
}

public final class ActivityRepositoryImpl: BaseProvider, ActivityRepository {
    public var event = PublishSubject<ActivityRepositoryEvent>()
    
    public func getActivities(_ dto: ActivityDTO.Request.ListRequestDTO) {
        
        NetworkService.shared.activityRepository.getActivityList(dto) { [weak self] res, err in
            guard let self = self else { return }
            guard let data = res?.data else {
                let errorModel = ErrorModel(
                    success: res?.success,
                    status: res?.status,
                    message: res?.message
                )
                
                self.event.onNext(.sendError(errorModel))
                return
            }
            
            self.event.onNext(.contents(data.contents))
            self.event.onNext(.activitiesLastPage(data.lastPage))
            self.event.onNext(.activitiesNextPage(data.nextPage))
        }
    }
}
