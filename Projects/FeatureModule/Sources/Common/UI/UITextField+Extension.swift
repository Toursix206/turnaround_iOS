//
//  UITextField+Extension.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftPadding(_ amount: CGFloat) {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
      self.leftView = paddingView
      self.leftViewMode = .always
    }
}
