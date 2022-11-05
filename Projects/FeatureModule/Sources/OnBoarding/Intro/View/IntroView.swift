//
//  IntroView.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/10/30.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit

class IntroView: UIView {
    
    var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1.0)
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        return pageControl
    }()
    
    var skipButton: UIButton = {
        var button = UIButton()
        button.setImage(FeatureModuleAsset.skipButton.image, for: .normal)
        return button
    }()
    
    var nextButton: UIButton = {
        var button = UIButton()
        button.setImage(FeatureModuleAsset.onBoardingButton.image, for: .normal)
        return button
    }()
    
    var signInWithKakakoButton: UIButton = {
        var button = UIButton()
        button.setImage(FeatureModuleAsset.signWithKakaoButton.image, for: .normal)
        button.isHidden = true
        return button
    }()
    
    /*
     임시 Apple 로그인 버튼!
     
     var signInWithAppleButtonTemp: UIButton = {
     
     var button = UIButton()
     button.backgroundColor = .red
     
     return button
     }()
     
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
        [skipButton,
         pageControl,
         signInWithKakakoButton,
         //         signInWithAppleButtonTemp,
         nextButton
        ].forEach { addSubview($0) }
        
        skipButton.snp.makeConstraints { make in
            make.width.equalTo(103)
            make.height.equalTo(24)
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(515)
            make.centerX.equalToSuperview()
        }
        
        signInWithKakakoButton.snp.makeConstraints { make in
            make.width.equalTo(328)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).inset(593)
        }
        
        /*
         
         임시 Apple 로그인 버튼
         
         signInWithAppleButtonTemp.snp.makeConstraints { make in
         make.width.equalTo(328)
         make.height.equalTo(52)
         make.centerX.equalToSuperview()
         make.top.equalToSuperview().offset(696)
         }
         
         */
        
        nextButton.snp.makeConstraints { make in
            make.width.height.equalTo(54)
            make.top.equalTo(safeAreaLayoutGuide).inset(593)
            make.centerX.equalToSuperview()
        }
    }
    
    
    
}
