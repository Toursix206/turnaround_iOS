//
//  TurnAroundTabBarItem.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

enum TurnAroundTabBarItem: String, CaseIterable {
    case home
    case bangtaverse
    case activity
    case mypage
}

extension TurnAroundTabBarItem {
    var viewController: UIViewController {
        switch self {
        case .home:
            return UINavigationController(rootViewController: FirstViewController())
        case .bangtaverse:
            return UINavigationController(rootViewController: BangtaverseMainViewController())
        case .activity:
            return UINavigationController(rootViewController: ThirdViewController())
        case .mypage:
            let reactor = MyPageReactor()
            return UINavigationController(rootViewController: MyPageViewController(reactor))
        }
    }

    var unselectedIcon: UIImage {
        switch self {
        case .home:
            return FeatureModuleAsset.ImageAsset.homeTabUnselected.image
        case .bangtaverse:
            return FeatureModuleAsset.ImageAsset.bangtaverseTabUnselected.image
        case .activity:
            return FeatureModuleAsset.ImageAsset.activityTabUnselected.image
        case .mypage:
            return FeatureModuleAsset.ImageAsset.mypageTabUnselected.image
        }
    }

    var selectedIcon: UIImage {
        switch self {
        case .home:
            return FeatureModuleAsset.ImageAsset.homeTabSelected.image
        case .bangtaverse:
            return FeatureModuleAsset.ImageAsset.bangtaverseTabSelected.image
        case .activity:
            return FeatureModuleAsset.ImageAsset.activityTabSelected.image
        case .mypage:
            return FeatureModuleAsset.ImageAsset.mypageTabSelected.image
        }
    }

    var name: String {
        switch self {
        case .home:
            return "홈"
        case .bangtaverse:
            return "방타버스"
        case .activity:
            return "활동"
        case .mypage:
            return "마이"
        }
    }
}
