//
//  ActivityStartView.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/14.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import Then

final class ActivityStartView: UIView {
    
    // MARK: - UI Components
    
    let exitButton = UIButton(type: .custom).then {
        $0.setImage(FeatureModuleAsset.exitButton.image, for: .normal)
    }
    
    let imageView = UIImageView(image: FeatureModuleAsset.activityStart.image).then {
        $0.makeRounded(cornerRadius: 16)
        $0.contentMode = .scaleAspectFill
    }
    
    let startButton = UIButton(type: .custom).then {
        $0.setAttributedTitle(NSAttributedString(string: "시작",
                                                 attributes: [.font: UIFont.customFont(.body1SemiBold),
                                                              .foregroundColor: UIColor.white]),
                              for: .normal)
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
        $0.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
    }
    
    // MARK: - Intializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    
    private func render() {
        addSubViews([exitButton, imageView, startButton])
        
        exitButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.width.height.equalTo(24)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(exitButton.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(550)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-68)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(56)
        }
    }
}
