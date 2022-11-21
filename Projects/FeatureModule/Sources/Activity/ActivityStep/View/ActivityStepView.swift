//
//  ActivityStepView.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import Then

final class ActivityStepView: UIView {
    
    // MARK: - UI Components
    
    let exitButton = UIButton(type: .custom).then {
        $0.setBackgroundImage(FeatureModuleAsset.exitButton.image, for: .normal)
    }
    
    let stepLabel = UIButton(type: .custom).then {
        $0.layer.backgroundColor = UIColor.black.cgColor
        $0.makeRounded(cornerRadius: 13)
        $0.isUserInteractionEnabled = false
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont.customFont(.subHeadLineBold)
    }
    
    let subtitleLabel = UILabel().then {
        $0.textColor = UIColor.gray
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont.customFont(.body2Regular)
    }
    
    let progressBar = UIProgressView(progressViewStyle: .bar).then {
        $0.makeRounded(cornerRadius: 7)
        $0.trackTintColor = UIColor.gray
        $0.progressTintColor = UIColor.black
        $0.progress = 0.25
        $0.layer.sublayers![1].cornerRadius = 7
        $0.subviews[1].clipsToBounds = true
    }
    
    let stepIndicatorLabel = UILabel().then {
        $0.font = UIFont(font: FeatureModuleFontFamily.Pretendard.regular, size: 14)?.withSize(14)
    }
    
    let imageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 16)
    }
    
    let completeButton = UIButton(type: .custom).then {
        $0.makeRounded(cornerRadius: 14)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func render() {
        addSubViews([exitButton, stepLabel, titleLabel, subtitleLabel,
                     progressBar, stepIndicatorLabel, imageView, completeButton])
        
        exitButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.width.height.equalTo(24)
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(70)
            $0.height.equalTo(26)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        stepIndicatorLabel.snp.makeConstraints {
            $0.centerY.equalTo(progressBar.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        progressBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(14)
            $0.trailing.equalTo(stepIndicatorLabel.snp.leading).offset(-8)
            $0.top.equalTo(stepLabel.snp.bottom).offset(143)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(180)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-164)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(56)
        }
    }
}
