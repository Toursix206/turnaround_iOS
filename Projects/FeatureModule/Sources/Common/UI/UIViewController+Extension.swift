//
//  UIViewController+Extension.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/12/20.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

extension UIViewController {

  public func changeRootViewController(to rootVC: UIViewController) {
    self.view.window?.rootViewController?.dismiss(animated: false) {

      rootVC.modalPresentationStyle = .fullScreen

      self.view.window?.rootViewController = rootVC
      self.view.window?.makeKeyAndVisible()
    }
  }

  public func setTabBarIsHidden(isHidden: Bool) {
    if let tvc = navigationController?.tabBarController as? TurnAroundTabBarViewController {
      tvc.backgroundView.isHidden = isHidden
    }
  }
}
