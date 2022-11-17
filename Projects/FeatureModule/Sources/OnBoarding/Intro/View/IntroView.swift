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

    enum Size {
        static let widthRatio = UIScreen.main.bounds.width / 896
        static let heightRatio = UIScreen.main.bounds.height / 896
        static let itemSize = CGSize(width: 360 * widthRatio, height: 390 * heightRatio)
    }

    var introCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Size.itemSize
        layout.minimumLineSpacing = 0
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.register(cell: IntroCollectionViewCell.self)
    }
    
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
        button.setImage(FeatureModuleAsset.kakaoButton.image, for: .normal)
        button.isHidden = true
        return button
    }()

    var signInWithAppleButton: UIButton = {
        var button = UIButton()
        button.setImage(FeatureModuleAsset.appleButton.image, for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
        [introCollectionView,
         skipButton,
         pageControl,
         signInWithKakakoButton,
         signInWithAppleButton,
         nextButton
        ].forEach { addSubview($0) }
        
        skipButton.snp.makeConstraints { make in
            make.width.equalTo(103)
            make.height.equalTo(24)
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }

        introCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(introCollectionView.snp.width).multipliedBy(13/12)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(introCollectionView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        signInWithKakakoButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(52)
            make.top.equalTo(pageControl.snp.bottom).offset(24 * UIScreen.main.bounds.height / 896)
        }

        signInWithAppleButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(52)
            make.top.equalTo(signInWithKakakoButton.snp.bottom).offset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.height.equalTo(54)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(60)
            make.centerX.equalToSuperview()
        }
    }
    
    
    
}
