//
//  KakaoAuthService.swift
//  ServiceModule
//
//  Created by 강민성 on 2022/11/07.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit
import RxSwift

import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class KakaoAuthServiceImpl: AuthService {
    
    fileprivate var appKey: String? = nil
    fileprivate var accessToken: String? = nil {
        willSet {
            UserDefaults.standard.set("KAKAO", forKey: "LoginState")
        }
    }
    
    weak var viewController: UIViewController?
    
    init(appKey: String) {
        self.appKey = appKey
    }
    
    func getCurrentAccessToken() {
        if let oAuthToken = KakaoSDKAuth.TokenManager.manager.getToken() {
            self.accessToken = oAuthToken.accessToken
        }
    }
    
    func hasToken() -> Single<AuthState> {
        return Single.create { [weak self] observer in
            if AuthApi.hasToken() {
                UserApi.shared.accessTokenInfo { (accessToken, error) in
                    if let error = error {
                        print(error)
                        observer(.success(AuthState.unAuthenticated))
                        return
                    }
                    self?.getCurrentAccessToken()
                    observer(.success(AuthState.authenticated))
                }
            }
            else {
                observer(.success(AuthState.unAuthenticated))
            }
            return Disposables.create()
        }
    }
    
    func isAvailableDevice() -> Bool {
        return UserApi.isKakaoTalkLoginAvailable()
    }
    
    func loginWithApp() -> Single<AuthError> {
        return Single.create { [weak self] observer in
            UserApi.shared.loginWithKakaoTalk { (oAuthToken, error) in
                if let error = error {
                    print(error)
                    observer(.failure(AuthError.fail))
                    return
                }
                
                guard let accessToken = oAuthToken?.accessToken else {
                    print("Invaild Kakao AccessToken")
                    observer(.failure(AuthError.fail))
                    return
                }
                
                self?.accessToken = accessToken
                observer(.success(AuthError.success))
            }
            return Disposables.create()
        }
    }
    
    func loginWithoutApp() -> Single<AuthError> {
        return Single.create { [weak self] observer in
            UserApi.shared.loginWithKakaoAccount { (oAuthToken, error) in
                if let error = error {
                    print(error)
                    observer(.failure(AuthError.fail))
                    return
                }
                
                guard let accessToken = oAuthToken?.accessToken else {
                    print("Invalid Kakao AccessToken")
                    observer(.failure(AuthError.fail))
                    return
                }
                
                self?.accessToken = accessToken
                observer(.success(AuthError.success))
            }
            return Disposables.create()
        }
    }
    
    func initialize() {
        guard self.appKey != nil else {
            print("Failed to initialize KakaoSDK")
            return
        }
        KakaoSDK.initSDK(appKey: self.appKey!)
    }
    
    func setViewController(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func handleRedirectURL(redirectURL: URL) -> Bool {
        if AuthApi.isKakaoTalkLoginUrl(redirectURL) == false {
            print("Failed to Redirect to URL")
            return false
        }
        return AuthController.handleOpenUrl(url: redirectURL)
    }
    
    func getAccessToken() -> String {
        if let accessToken = self.accessToken {
            return accessToken
        }
        return ""
    }
    
    
    func isInstalled() -> Single<Bool> {
        return Single.create { [weak self] observer in
            let result: Bool = (self?.isAvailableDevice())!
            observer(.success(result))
            return Disposables.create()
        }
    }
    
    func isAuthenticated() -> RxSwift.Single<AuthState> {
        self.hasToken()
    }
    
    func authenticate() -> RxSwift.Single<AuthError> {
        if self.isAvailableDevice() {
            return self.loginWithApp()
        }
        return self.loginWithoutApp()
    }
    
    
}
