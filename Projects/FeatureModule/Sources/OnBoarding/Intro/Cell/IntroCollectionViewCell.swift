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
        label.font = UIFont.customFont(.H2Bold)
        label.numberOfLines = 0
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
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(slideImageView.snp.height).multipliedBy(1.2)
        }
        
        slideDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(slideImageView.snp.bottom)
        }
    }
}
