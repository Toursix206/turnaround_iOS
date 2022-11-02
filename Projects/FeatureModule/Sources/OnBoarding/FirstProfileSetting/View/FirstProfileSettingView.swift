//
//  FirstProfileSettingView.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import Then
import SnapKit

class FirstProfileSettingView: UIView {

    var guideLabel = UILabel().then {
        $0.font = fonts
        $0.text = "프로필과 닉네임을\n설정해주세요!"
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.lineBreakStrategy = .hangulWordPriority
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
