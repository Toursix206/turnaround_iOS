//
//  IntroCollectionViewCell.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/10/30.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit

class IntroCollectionViewCell: UICollectionViewCell {
    
    var slideImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    var slideDescriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(font: FeatureModuleFontFamily.Pretendard.bold, size: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
        [slideImageView, slideDescriptionLabel].forEach { addSubview($0) }
        
        slideImageView.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            
        }
        
        slideDescriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(178)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(444)
        }
    }
}
