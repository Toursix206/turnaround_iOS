//
//  Keychain.swift
//  ServiceModule
//
//  Created by 김지현 on 2022/11/09.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import SwiftKeychainWrapper

public final class Keychain {

  public static var shared = Keychain()
  private init() { }
  private let keychain: KeychainWrapper = KeychainWrapper.standard

  private var accessTokenKey = "accessTokenKey"
  private let refreshTokenKey = "refreshTokenKey"
  private let fcmTokenKey = "FCMTokenKey"
}

extension Keychain {
  public func setAccessToken(accessToken: String?) {
    self.keychain.removeObject(forKey: accessTokenKey)
    self.keychain.set(accessToken ?? "", forKey: accessTokenKey)
  }
  public func setRefreshToken(refreshToken: String?) {
    self.keychain.removeObject(forKey: refreshTokenKey)
    self.keychain.set(refreshToken ?? "", forKey: refreshTokenKey)
  }

  public func setFCMToken(fcmToken: String) {
    self.keychain.set(fcmToken, forKey: fcmTokenKey)
  }

  // MARK: -
  public func getAccessToken() -> String? {
    return self.keychain.string(forKey: accessTokenKey)
  }

  public func getRefreshToken() -> String? {
    return self.keychain.string(forKey: refreshTokenKey)
  }

  public func getFCMToken() -> String? {
    return self.keychain.string(forKey: fcmTokenKey)
  }

  public func removeAllKeys() {
    self.keychain.removeAllKeys()
  }
}
