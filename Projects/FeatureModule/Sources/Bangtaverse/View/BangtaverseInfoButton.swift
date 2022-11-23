//
//  BangtaverseInfoButton.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

class BangtaverseInfoButton: UIControl {

    enum ButtonType {
        case brush, score
    }

    var buttonType: ButtonType?

    var imageView = UIImageView().then {
        $0.image = FeatureModuleAsset.ImageAsset.bigBrush.image
    }
    var numberLabel = UILabel().then {
        $0.font = UIFont.customFont(.H2Bold)
        $0.textAlignment = .right
        $0.text = "0"
    }
    var unitLabel = UILabel().then {
        $0.font = UIFont.customFont(.captionRegular)
        $0.textAlignment = .left
        $0.text = "개"
    }
    var arrowImage = UIImageView().then {
        $0.image = FeatureModuleAsset.ImageAsset.bangtaverseArrow.image
    }

    init(type: ButtonType) {
        super.init(frame: .zero)
        setup(type)
        render()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(_ type: ButtonType) {
        self.layer.applySketchShadow(color: .black, alpha: 0.12, x: 0, y: 4, blur: 15, spread: 0)
        makeRounded(cornerRadius: 28)
        self.backgroundColor = .white
        self.buttonType = type

        switch type {
        case .brush:
            imageView.image = FeatureModuleAsset.ImageAsset.bigBrush.image
            unitLabel.text = "개"
        case .score:
            imageView.image = FeatureModuleAsset.ImageAsset.bigScore.image
            unitLabel.text = "점"
        }
    }

    private func render() {
        addSubViews([imageView, numberLabel, unitLabel, arrowImage])

        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
        }

        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(2)
            make.centerY.equalToSuperview()
        }

        unitLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }

        arrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }
}
