//
//  AuthService.swift
//  ServiceModuleTests
//
//  Created by 강민성 on 2022/11/07.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import ReactorKit

public protocol AuthService {
    
    func initialize()
    func setViewController(viewController: UIViewController?)
    func handleRedirectURL(redirectURL: URL) -> Bool
    func getAccessToken() -> String
    
    func isInstalled() -> Single<Bool>
    func isAuthenticated() -> Single<AuthState>
    func authenticate() -> Single<AuthError>
}

public enum AuthError: Error {
    case success
    case fail
}

public enum AuthType: String {
    case kakao = "KAKAO"
    case apple = "APPLE"
    case none = "none"
}

public enum AuthState {
    case unAuthenticated
    case authenticated
}

public enum LoginState {
    case login
    case logout
    case unregistered
}

