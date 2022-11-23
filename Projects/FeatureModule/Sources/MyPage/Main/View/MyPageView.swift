//
//  MyPageView.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

class MyPageView: UIView {
    
    var userProfileView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var userProfileLabel: UILabel = {
       var label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.customFont(.body2SemiBold)
        label.text = "턴어라운드"
        label.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        return label
    }()
    
    var userProfileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = FeatureModuleAsset.ColorAsset.gray2.color
        imageView.makeRounded(cornerRadius: 69.6)
        imageView.image = FeatureModuleAsset.ImageAsset.memoji2.image
        return imageView
    }()
    
    var earningPointView: UIView = {
       var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var earningPointImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = FeatureModuleAsset.ImageAsset.point.image
        return imageView
    }()
    
    var earningPointTitleLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.customFont(.body1Regular)
        label.text = "터닝 포인트"
        label.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        return label
    }()
    
    var earningPointCountLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.customFont(.body2SemiBold)
        label.text = "1,000"
        label.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        return label
    }()
    
    var tableView: UITableView = {
       var tableView = UITableView()
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        userProfileView.addSubViews([userProfileLabel, userProfileImageView])
        earningPointView.addSubViews([earningPointImageView, earningPointCountLabel, earningPointTitleLabel])
        
        addSubViews([userProfileView, earningPointView, tableView])
    }
}
