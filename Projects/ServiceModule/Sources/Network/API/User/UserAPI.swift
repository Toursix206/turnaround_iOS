//
//  UserAPI.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/17.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

protocol UserAPIProtocol {

    func checkNickname(
        _ checkNicknameRequestDTO: UserDTO.Request.CheckNicnameRequestDTO,
        completion: @escaping (BaseResponseType<String>?, Error?) -> Void
    )


}

public final class UserAPI: APIRequestLoader<UserService>, UserAPIProtocol {

    public func checkNickname(_ checkNicknameRequestDTO: UserDTO.Request.CheckNicnameRequestDTO, completion: @escaping (BaseResponseType<String>?, Error?) -> Void) {

        fetchData(
            target: .checkNickname(checkNicknameRequestDTO),
            responseData: BaseResponseType<String>.self,
            isWithInterceptor: false
        ) { res, err in
            completion(res, err)
        }
    }




}
