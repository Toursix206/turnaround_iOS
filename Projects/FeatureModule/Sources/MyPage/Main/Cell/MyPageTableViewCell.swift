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
        
        return label
    }()
    
    func bind(reactor: MyPageTableViewCellReactor) {
        cellTitleLabel.text = reactor.currentState.title
        iconView.image = reactor.currentState.icon
    }

}
