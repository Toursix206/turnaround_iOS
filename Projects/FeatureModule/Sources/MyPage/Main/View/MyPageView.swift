//
//  MyPageView.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import Then

class MyPageView: UIView {
    
//    var navigationTitleLabel = UILabel().then {
//        $0.font = UIFont.customFont(.body1SemiBold)
//        $0.text = "마이페이지"
//    }
    
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
        // -MARK: 스택뷰로 프로필 사진 만들어야됨!
        imageView.makeRounded(cornerRadius: 36.6)
//        self.contentView.frame.width/2
        imageView.image = FeatureModuleAsset.ImageAsset.memoji2.image
        return imageView
    }()
    
    var firstEmptyView: UIView = {
        var view = UIView()
        view.backgroundColor = FeatureModuleAsset.ColorAsset.gray2.color
        return view
    }()
    
    var secondEmptyView: UIView = {
        var view = UIView()
        view.backgroundColor = FeatureModuleAsset.ColorAsset.gray2.color
        return view
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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.className)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        userProfileView.addSubViews([userProfileLabel, userProfileImageView])
        earningPointView.addSubViews([earningPointImageView, earningPointCountLabel, earningPointTitleLabel])
        
        addSubViews([userProfileView, firstEmptyView, earningPointView, secondEmptyView, tableView])
        
        userProfileView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(111)
        }
        
        userProfileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
        }
        
        userProfileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.leading.equalTo(userProfileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
        
        firstEmptyView.snp.makeConstraints { make in
            make.top.equalTo(userProfileView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(earningPointView.snp.top)
        }
        
        
        earningPointView.snp.makeConstraints { make in
            make.top.equalTo(userProfileView.snp.bottom).offset(10)
            make.height.equalTo(64)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        earningPointImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
//            make.trailing.equalToSuperview().offset(329)
        }
        
        earningPointTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(earningPointImageView.snp.trailing).offset(10)
            make.trailing.equalTo(earningPointCountLabel.snp.leading)
        }
        
        earningPointCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-22)
        }
        
        secondEmptyView.snp.makeConstraints { make in
            make.top.equalTo(earningPointView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
        }
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(earningPointView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        
        
    }
}
