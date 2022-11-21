//
//  ActivityReviewView.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/18.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxGesture

public final class ActivityReviewView: UIView {
    
    let backButton = UIButton(type: .custom).then {
        $0.setImage(FeatureModuleAsset.backButton.image, for: .normal)
    }
    
    private let navigationTitleLabel = UILabel().then {
        $0.font = UIFont.customFont(.body1SemiBold)
        $0.text = "활동 리뷰"
    }
    
    let skipButton = UIButton(type: .custom).then {
        $0.setAttributedTitle(NSAttributedString(string: "건너뛰기", attributes: [.font: UIFont.customFont(.body1SemiBold), .foregroundColor: UIColor.purple]), for: .normal)
    }
    
    let imageView = UIImageView().then {
        $0.makeRounded(cornerRadius: 9)
        $0.backgroundColor = UIColor.gray
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.customFont(.body1SemiBold)
        $0.text = "시험공부가 저절로 잘되는\n책상정리 꿀팁!"
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont.customFont(.body2Regular)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        $0.text = "\(dateFormatter.string(from: Date.now))"
    }
    
    let ratingLabel = UILabel().then {
        $0.font = UIFont.customFont(.body2SemiBold)
        $0.text = "별점 등록 (0/5)"
    }
    
    let ratingSlider = UISlider().then {
        $0.minimumTrackTintColor = .clear
        $0.maximumTrackTintColor = .clear
        $0.thumbTintColor = .clear
        $0.tintColor = .clear
        $0.maximumValue = 5
        $0.minimumValue = 0
    }
    
    let ratingStarStack = UIStackView(arrangedSubviews: [
        UIImageView(image: FeatureModuleAsset.star.image).then {
            $0.tag = 1
        },
        UIImageView(image: FeatureModuleAsset.star.image).then {
            $0.tag = 2
        },
        UIImageView(image: FeatureModuleAsset.star.image).then {
            $0.tag = 3
        },
        UIImageView(image: FeatureModuleAsset.star.image).then {
            $0.tag = 4
        },
        UIImageView(image: FeatureModuleAsset.star.image).then {
            $0.tag = 5
        }
    ]).then {
        $0.spacing = 4
        $0.axis = .horizontal
    }
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = UIColor.gray
    }
    
    private let guideLabel = UILabel().then {
        let text = "오늘의 활동은 어떠셨나요? (10자 이상)"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: UIFont.customFont(.body1SemiBold), range: (text as NSString).range(of: "오늘의 활동은 어떠셨나요?"))
        attributedText.addAttribute(.font, value: UIFont.customFont(.body1Regular), range: (text as NSString).range(of: "(10자 이상)"))
        $0.attributedText = attributedText
    }
    
    private let textViewBackground = UIView().then {
        $0.makeRounded(cornerRadius: 16)
        $0.backgroundColor = UIColor.white
    }
    
    let textView = UITextView().then {
        $0.makeRounded(cornerRadius: 16)
        $0.textColor = UIColor.lightGray
//        $0.attributedText = NSAttributedString(string: "사진과 함께 리뷰를 작성하면 터닝포인트 적립가능! 활동 후 솔직한 경험을 말해주세요.", attributes: [.foregroundColor: UIColor.lightGray])
        $0.font = UIFont.customFont(.body1Regular)
        $0.isEditable = true
        $0.textColor = UIColor.black
    }
    
    let textCountLabel = UILabel().then {
        $0.font = UIFont.customFont(.body2Regular)
        $0.textColor = UIColor.gray
    }
    
    let completeButton = UIButton(type: .custom).then {
        $0.setAttributedTitle(NSAttributedString(string: "작성완료",
                                                 attributes: [.font: UIFont.customFont(.body1SemiBold),
                                                              .foregroundColor: UIColor.white]),
                              for: .normal)
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
        $0.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
    }
    
    // MARK: - Initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        addSubViews([backButton, navigationTitleLabel, skipButton,
                    imageView, titleLabel, dateLabel,
                    ratingLabel, ratingStarStack, ratingSlider,
                    separatorLine,
                    guideLabel,
                    textViewBackground, textView, textCountLabel,
                    completeButton])
        
        backButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.width.height.equalTo(24)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        skipButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-18)
            $0.centerY.equalTo(backButton.snp.centerY)
//            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(72)
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(36)
            $0.leading.equalTo(imageView.snp.trailing).offset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(26)
        }
        
        ratingStarStack.snp.makeConstraints {
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(21)
            $0.trailing.equalToSuperview().offset(-22)
//            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.centerY.equalTo(ratingLabel.snp.centerY)
            $0.height.equalTo(36)
        }
        
        ratingSlider.snp.makeConstraints {
            $0.leading.equalTo(ratingStarStack.snp.leading)
            $0.trailing.equalTo(ratingStarStack.snp.trailing)
            $0.centerY.equalTo(ratingStarStack.snp.centerY)
        }
        
        separatorLine.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.top.equalTo(ratingStarStack.snp.bottom).offset(20)
            $0.height.equalTo(1)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        textViewBackground.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(200)
        }
        
        textView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(textViewBackground)
            $0.height.equalTo(170)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(textViewBackground.snp.trailing).offset(-14)
            $0.bottom.equalTo(textViewBackground.snp.bottom).offset(-10)
        }
        
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(56)
        }
    }
}
