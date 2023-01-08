//
//  ActivityCategoryCell.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/25.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit
import Then

final class ActivityCategoryCell: UICollectionViewCell, View {
    
    typealias Reactor = ActivityCategoryCollectionViewCellReactor
    
    var disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    let imageView = UIImageView().then {
        $0.image = UIImage(asset: FeatureModuleImages(name: "Star_On"))
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.customFont(.body2Regular)
        $0.text = "전체"
    }
    
    // MARK: - Life Cycle
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - render
    
    private func render() {
        addSubViews([imageView, titleLabel])
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
        }
    }
    
    func bind(reactor: Reactor) {
        imageView.kf.setImage(with: reactor.currentState.imageURL)
        titleLabel.text = reactor.currentState.title
    }
}
