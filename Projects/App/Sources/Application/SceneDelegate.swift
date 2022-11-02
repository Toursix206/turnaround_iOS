//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 2022/10/10.
//

import UIKit

import FeatureModule

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        /*
         최초 실행
         
         최초실행 인가? -> true -> 온보딩 화면으로 넘기기
         최초실행이 아닌가? -> false -> 메인 하면으로 넘기기
         
         이후 회원가입 API가 적용된다면 회원가입 여부로 리팩토링해야됨!
         */
        
        let isNotFirstTime = UserDefaults.standard.bool(forKey: "isNotFirstTime")
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        debugPrint(isNotFirstTime)
        switch isNotFirstTime {
        case true:
            // 최초실행 O -> 온보딩 화면 넘기기
            UserDefaults.standard.set(false, forKey: "isNotFristTime")
            let viewController = IntroViewController()
            
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.backgroundColor = .systemBackground
            window?.windowScene = windowScene
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        case false:
            // 최초실행 X -> 메인 화면 넘기기
            let viewController = RoomTestViewController()
            
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.backgroundColor = .systemBackground
            window?.windowScene = windowScene
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

