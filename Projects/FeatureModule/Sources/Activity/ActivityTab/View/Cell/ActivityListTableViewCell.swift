//
//  ActivityListTableViewCell.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/25.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit
import Kingfisher

final class ActivityListTableViewCell: UITableViewCell, View {
    
    typealias reactor = ActivityListTableViewCellReactor
    
    static let identifier = "ActivityListTableViewCell"
    
    enum Price {
        case free, kit
    }
    
    var price: Price = .free {
        didSet {
            switch price {
            case .free:
                priceLabel.text = "FREE"
                priceLabel.textColor = FeatureModuleAsset.ColorAsset.gray9.color
                priceLabel.layer.borderColor = FeatureModuleAsset.ColorAsset.gray9.color.cgColor
            case .kit:
                priceLabel.text = "KIT"
                priceLabel.textColor = FeatureModuleAsset.ColorAsset.point.color
                priceLabel.layer.borderColor = FeatureModuleAsset.ColorAsset.point.color.cgColor
            }
        }
    }
    
    public var disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    let activityImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.makeRounded(cornerRadius: 16)
    }
    
    let priceLabel = UILabel().then {
        $0.makeRounded(cornerRadius: 4)
        $0.font = UIFont.customFont(.body1Bold)
    }
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        $0.font = UIFont.customFont(.body1SemiBold)
        $0.text = "밀린 설거지 하기"
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = FeatureModuleAsset.ColorAsset.gray6.color
        $0.font = UIFont.customFont(.body2Regular)
        $0.text = "꼭 오늘은 설거지 해보자고요!"
        $0.numberOfLines = 1
    }
    
    
    // MARK: - initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layout
    
    private func render() {
        addSubViews([activityImageView, priceLabel, titleLabel, descriptionLabel])
        
        makeRounded(cornerRadius: 16)
        
        activityImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-15)
            $0.width.equalToSuperview().offset(84)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(activityImageView.snp.trailing).offset(14)
            $0.top.equalToSuperview().offset(17)
            $0.width.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(activityImageView.snp.trailing).offset(14)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-2)
            $0.leading.equalTo(activityImageView.snp.trailing).offset(14)
        }
    }
    
    // bind with reactor
    func bind(reactor: ActivityListTableViewCellReactor) {
        activityImageView.kf.setImage(with: reactor.currentState.imageURL)
        switch reactor.currentState.type {
        case "FREE":
            price = .free
        case "KIT":
            price = .kit
        default:
            price = .free
        }
        titleLabel.text = reactor.currentState.title
        descriptionLabel.text = reactor.currentState.description
        
    }
}
