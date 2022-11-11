//
//  UIStackView+Extension.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: UIView...) {
    for view in views {
      self.addArrangedSubview(view)
    }
  }
}
