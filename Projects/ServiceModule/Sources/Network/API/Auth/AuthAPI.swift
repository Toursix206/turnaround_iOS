//
//  AuthAPI.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

protocol AuthAPIProtocol {

    func refresh(
        _ refreshRequestDTO: Token,
        completion: @escaping (BaseResponseType<AuthDTO.Response.AuthResponseDTO>?, Error?) -> Void
    )

    func login(
        _ loginRequestDTO: AuthDTO.Request.LoginRequestDTO,
        completion: @escaping (BaseResponseType<AuthDTO.Response.AuthResponseDTO>?, Error?) -> Void
    )
    func signup(
        _ signupRequestDTO: AuthDTO.Request.SignupRequestDTO,
        completion: @escaping (BaseResponseType<AuthDTO.Response.AuthResponseDTO>?, Error?) -> Void
    )
}

public final class AuthAPI: APIRequestLoader<AuthService>, AuthAPIProtocol {

    public func refresh(
        _ refreshRequestDTO: Token,
        completion: @escaping (BaseResponseType<AuthDTO.Response.AuthResponseDTO>?, Error?) -> Void) {
            fetchData(
                target: .refresh(refreshRequestDTO),
                responseData: BaseResponseType<AuthDTO.Response.AuthResponseDTO>.self,
                isWithInterceptor: false
            ) { res, err in
                completion(res, err)
            }
        }

    public func login(
        _ loginRequestDTO: AuthDTO.Request.LoginRequestDTO,
        completion: @escaping (BaseResponseType<AuthDTO.Response.AuthResponseDTO>?, Error?) -> Void) {
        fetchData(
            target: .login(loginRequestDTO),
            responseData: BaseResponseType<AuthDTO.Response.AuthResponseDTO>.self,
            isWithInterceptor: false
        ) { res, err in
            completion(res, err)
        }
    }

    public func signup(
        _ signupRequestDTO: AuthDTO.Request.SignupRequestDTO,
        completion: @escaping (BaseResponseType<AuthDTO.Response.AuthResponseDTO>?, Error?) -> Void) {

        fetchData(
            target: .signup(signupRequestDTO),
            responseData: BaseResponseType<AuthDTO.Response.AuthResponseDTO>.self,
            isWithInterceptor: false
        ) { res, err in
            completion(res, err)
        }
    }
}
