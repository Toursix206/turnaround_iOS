//
//  KeychainManager.swift
//  ServiceModule
//
//  Created by 강민성 on 2022/11/07.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import Security

public enum KeyChainManager {
    
    public static func createToken(token: String, key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(
                using: .utf8,
                allowLossyConversion: false
            ) as Any
        ]
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        
        assert(status == noErr, "Failed to create AccessToken")
    }
    
    public static func readToken(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            let retrivedData = dataTypeRef as! Data
            let value = String(
                data: retrivedData,
                encoding: String.Encoding.utf8
            )
            return value
        }
        else {
            print("Failed to read AccessToken, Error code = \(status)")
            return nil
        }
    }
}
