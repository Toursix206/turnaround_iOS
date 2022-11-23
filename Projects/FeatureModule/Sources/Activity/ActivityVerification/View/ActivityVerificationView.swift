//
//  ActivityVerificationView.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/16.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

class ActivityVerificationView: UIView {
    
    // MARK: - UI Components
    
    let exitButton = UIButton(type: .custom).then {
        $0.setBackgroundImage(FeatureModuleAsset.ImageAsset.exitButton.image, for: .normal)
    }
    
    let completeImageView = UIImageView(image: FeatureModuleAsset.ImageAsset.activityComplete.image).then {
        $0.contentMode = .scaleAspectFill
        $0.makeRounded(cornerRadius: 16)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "활동 인증"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont.customFont(.H2Bold)
    }
    
    let subtitleLabel = UILabel().then {
        $0.text = "해당 사진으로 집안일을 인증 하시겠습니까?"
        $0.textColor = UIColor.gray
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont.customFont(.body1Regular)
    }
    
    let cameraImageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 16)
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = UIColor.gray
    }
    
    let retakeButton = UIButton().then {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.makeRounded(cornerRadius: 15)
        $0.setAttributedTitle(NSAttributedString(string: "다시 찍기",
                                                 attributes: [.font: UIFont.customFont(.body2SemiBold)]),
                              for: .normal)
    }
    
    let verificationButton = UIButton(type: .custom).then {
        $0.makeRounded(cornerRadius: 14)
        $0.setAttributedTitle(NSAttributedString(string: "오늘의 활동 인증하기!",
                                                 attributes: [.font: UIFont.customFont(.body1SemiBold),
                                                              .foregroundColor: UIColor.white]),
                              for: .normal)
        $0.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
    }
    
    let confirmButton = UIButton(type: .custom).then {
        $0.makeRounded(cornerRadius: 14)
        $0.setAttributedTitle(NSAttributedString(string: "네! 이 사진으로 할게요.",
                                                 attributes: [.font: UIFont.customFont(.body1SemiBold),
                                                              .foregroundColor: UIColor.white]),
                              for: .normal)
        $0.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
    }
    
    lazy var initialHiddenGroup = [titleLabel, subtitleLabel, cameraImageView, retakeButton, confirmButton]
    
    lazy var laterHiddenGroup = [completeImageView, verificationButton]

    // MARK: - intializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        initialHiddenGroup.forEach {
            $0.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func render() {
        addSubViews([exitButton, completeImageView, titleLabel, subtitleLabel, cameraImageView, retakeButton, verificationButton, confirmButton])
        
        exitButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(exitButton.snp.bottom).offset(28)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.width.height.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(48)
        }
        
        retakeButton.snp.makeConstraints {
            $0.top.equalTo(cameraImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(78)
        }
        
        completeImageView.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalTo(verificationButton.snp.top).offset(-35)
        }
        
        verificationButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(56)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
}
