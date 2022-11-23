//
//  BangtaverseMainView.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

import SnapKit
import Then

class BangtaverseMainView: UIView {

    enum Size {
        static let detailViewheight = 76
        static let buttonHeight = 56
        static let progressBackgroundHeight = 30
    }

    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    var contentView = UIView()

    // 방 종류 & 가구 수 박스
    var detailView = UIView().then {
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 12)
    }
    var roomTypeGuideLabel = UILabel().then {
        $0.text = "방 종류"
        $0.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        $0.font = UIFont.customFont(.body1Bold)
    }
    var roomTypeLabel = UILabel().then {
        $0.text = "작은 취침 공간"
        $0.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        $0.font = UIFont.customFont(.body1Regular)
    }
    var itemNumGuideLabel = UILabel().then {
        $0.text = "가구 수"
        $0.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        $0.font = UIFont.customFont(.body1Bold)
    }
    var itemNumLabel = UILabel().then {
        $0.text = "3개"
        $0.textColor = FeatureModuleAsset.ColorAsset.gray10.color
        $0.font = UIFont.customFont(.body1Regular)
    }

    // 방타버스
    var roomView = UIView()
    var bangtaverseMainView = Bangtaverse()
    var roomGuideView = UIView().then {
        $0.makeRounded(cornerRadius: 12)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = FeatureModuleAsset.ColorAsset.gray4.color.cgColor
        $0.backgroundColor = .white
    }
    var roomGuideLabel = UILabel().then {
        $0.text = "작은방"
        $0.font = UIFont.customFont(.body2SemiBold)
        $0.textAlignment = .center
    }

    // infoView
    var infoView = UIView()
    var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 12
    }
    var brushButton = BangtaverseInfoButton(type: .brush)
    var scoreButton = BangtaverseInfoButton(type: .score)

    // infoView 안에 들어가는 progressView
    var progressBackgroundView = UIView().then {
        $0.backgroundColor = FeatureModuleAsset.ColorAsset.gray10.color
        $0.makeRounded(cornerRadius: 15)
    }
    var levelLabel = UILabel().then {
        $0.font = UIFont.customFont(.body2SemiBold)
        $0.textColor = .white
        $0.text = "Lv.1"
    }
    var progressBar = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.makeRounded(cornerRadius: 7)
        $0.layer.masksToBounds = true
        $0.trackTintColor = FeatureModuleAsset.ColorAsset.gray8.color
        $0.progressTintColor = .white
        $0.progress = 0.5
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BangtaverseMainView {

    private func setup() {
        backgroundColor = FeatureModuleAsset.ColorAsset.gray1.color
    }
    
    private func render() {

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews([detailView, roomView, infoView])

        detailView.addSubViews([roomTypeGuideLabel, roomTypeLabel,
                                itemNumGuideLabel, itemNumLabel])

        roomView.addSubViews([bangtaverseMainView, roomGuideView])
        roomGuideView.addSubview(roomGuideLabel)

        infoView.addSubViews([buttonStackView, progressBackgroundView])
        buttonStackView.addArrangedSubviews(brushButton, scoreButton)
        progressBackgroundView.addSubViews([levelLabel, progressBar])

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }

        // 방 종류, 가구 수
        detailView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(54)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(Size.detailViewheight)
        }
        roomTypeGuideLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(12)
        }
        roomTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(roomTypeGuideLabel.snp.trailing).offset(10)
            make.centerY.equalTo(roomTypeGuideLabel.snp.centerY)
        }
        itemNumGuideLabel.snp.makeConstraints { make in
            make.leading.equalTo(roomTypeGuideLabel.snp.leading)
            make.top.equalTo(roomTypeGuideLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(12)
        }
        itemNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(itemNumGuideLabel.snp.trailing).offset(10)
            make.centerY.equalTo(itemNumGuideLabel.snp.centerY)
        }

        // 방타버스
        roomView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(bangtaverseMainView.snp.width)
        }
        bangtaverseMainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        roomGuideView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
        roomGuideLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // infoView
        infoView.snp.makeConstraints { make in
            make.top.equalTo(bangtaverseMainView.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
            make.bottom.equalToSuperview().inset(100)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(Size.buttonHeight)
        }

        progressBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(16)
            make.height.equalTo(Size.progressBackgroundHeight)
            make.leading.trailing.equalToSuperview().inset(22)
            make.bottom.equalToSuperview().inset(28)
        }

        levelLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        progressBar.snp.makeConstraints { make in
            make.leading.equalTo(levelLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
