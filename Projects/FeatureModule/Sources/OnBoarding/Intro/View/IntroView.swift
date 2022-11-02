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
    
    var introView = UIView()
    
    var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.register(cell: IntroCollectionViewCell.self)
        }
    
    var signInWithKakakoButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .yellow
        return button
    }()
    
    /*
     임시 Apple 로그인 버튼!
     */
    
    var signInWithAppleButtonTemp: UIButton = {
        
        var button = UIButton()
        button.backgroundColor = .red
        
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
        
        addSubview(introView)
        [collectionView,
         signInWithKakakoButton,
         signInWithAppleButtonTemp
        ].forEach { addSubview($0) }
        
        signInWithKakakoButton.snp.makeConstraints { make in
            make.width.equalTo(328)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(634)
        }
        
        signInWithAppleButtonTemp.snp.makeConstraints { make in
            make.width.equalTo(328)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(696)
        }
    }
    
    
    
}
