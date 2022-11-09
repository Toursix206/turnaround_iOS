//
//  AuthServiceManager.swift
//  ServiceModule
//
//  Created by 강민성 on 2022/11/07.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

public class AuthServiceManager {
    
    static var kakaoService: AuthService? = nil
    
    static let appKey = "d22501ce396283c614192a90f04e3510"
    
    public static func getKakaoAuthService() -> AuthService {
        if self.kakaoService == nil {
            self.kakaoService = KakaoAuthServiceImpl(appKey: appKey)
        }
        return self.kakaoService!
    }
}
