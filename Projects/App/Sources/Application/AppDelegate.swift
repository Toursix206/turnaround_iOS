//
//  AppDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 2022/10/10.
//

import UIKit
import ServiceModule
import FeatureModule
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        RxImagePickerDelegateProxy.register { RxImagePickerDelegateProxy(imagePicker: $0) }
        AuthServiceManager.getKakaoAuthService().initialize()

        FirebaseApp.configure()
        registerRemoteNotification()

        Messaging.messaging().delegate = self

        removeKeychainAtFirstLaunch()
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

// deviceToken 등록 및 fcmToken setting
extension AppDelegate: UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let deviceTokenString = deviceToken.map {
            String(format: "%02x", $0)
        }.joined()

        print("deviceToken: \(deviceTokenString)")

        Messaging.messaging().apnsToken = deviceToken

        Messaging.messaging().token { token, err in
            if let err = err {
                print("Error fetching FCM registration token: \(err)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                Keychain.shared.setFCMToken(fcmToken: token)
            }
        }

    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
}

extension AppDelegate {

    private func registerRemoteNotification() {

        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: authOptions) { granted, _ in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                print("Permission granted: \(granted)")
            }
        }
    }

    private func removeKeychainAtFirstLaunch() {
      guard UserInformation.isFirstLaunch() else {
        return
      }

      Keychain.shared.removeAllKeys()
    }
}

