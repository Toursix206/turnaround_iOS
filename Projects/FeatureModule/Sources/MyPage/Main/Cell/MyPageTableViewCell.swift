//
//  MyPageTableViewCell.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift

class MyPageTableViewCell: UITableViewCell, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    typealias Reactor = MyPageTableViewCellReactor
    
    var iconView: UIImageView = {
       var imageView = UIImageView()
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var rightBracketImageVIew: UIImageView = {
       var imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = FeatureModuleAsset.ImageAsset.rightBracket.image
        return imageView
    }()
    
    var cellTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.customFont(.body1Regular)
        return label
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: MyPageTableViewCellReactor) {
        cellTitleLabel.text = reactor.currentState.title
        iconView.image = reactor.currentState.icon
    }
    
    func render() {
        
        contentView.addSubViews([iconView, rightBracketImageVIew, cellTitleLabel])
        
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
        }
        
        rightBracketImageVIew.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-22)
        }
        
        cellTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconView.snp.trailing).offset(10)
            make.trailing.equalTo(rightBracketImageVIew.snp.leading)
        }
        
    }

}
