//
//  RoomTestView.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/10/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import Then

enum DirtyLevel {
    case clean, dirty
}

class RoomTestView: UIView {

    //var dirtyLevel: DirtyLevel = .dirty

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var roomView = UIView()

    var emptyRoomImageView = UIImageView().then {
        $0.image = FeatureModuleAsset.roomWithHole.image
    }

    var deskAndChairImageView = UIImageView().then {
        $0.image = FeatureModuleAsset.deskAndChair.image
    }
    var bedImageView = UIImageView().then {
        $0.image = FeatureModuleAsset.bed.image
    }
    var windowImageView = UIImageView().then {
        $0.image = FeatureModuleAsset.transparentWindow.image
    }

    var deskAndChairTouchView = UIView()
    var bedTouchView = UIView()
    var windowTouchView = UIView()

    var deskAndChairBrushButton = UIButton()
    var bedBrushButton = UIButton()
    var windowBrushButton = UIButton()

    private func setup() {

        [deskAndChairBrushButton, bedBrushButton, windowBrushButton].forEach {
            //$0.isHidden = true
            $0.setImage(FeatureModuleAsset.brush.image, for: .normal)
        }
    }

    private func render() {

        addSubview(roomView)
        [emptyRoomImageView,
         bedImageView, deskAndChairImageView, windowImageView,
        bedTouchView, deskAndChairTouchView, windowTouchView,
        bedBrushButton, deskAndChairBrushButton, windowBrushButton
        ].forEach { roomView.addSubview($0) }

        roomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(roomView.snp.width)
            make.center.equalToSuperview()
        }

        emptyRoomImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        [bedImageView, deskAndChairImageView, windowImageView].forEach {
            $0.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalToSuperview()
            }
        }

        bedTouchView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.23)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview().multipliedBy(1.2)
            make.centerY.equalToSuperview().multipliedBy(1.17)
        }
        deskAndChairTouchView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.23)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview().multipliedBy(0.6)
            make.centerY.equalToSuperview().multipliedBy(1.23)
        }
        windowTouchView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.23)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.centerX.equalToSuperview().multipliedBy(0.6)
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }

        bedBrushButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.09)
            make.height.equalToSuperview().multipliedBy(0.11)
            make.bottom.equalTo(bedTouchView.snp.top)
            make.centerX.equalTo(bedTouchView.snp.centerX)
        }
        deskAndChairBrushButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.09)
            make.height.equalToSuperview().multipliedBy(0.11)
            make.bottom.equalTo(deskAndChairTouchView.snp.top).offset(4)
            make.centerX.equalTo(deskAndChairTouchView.snp.centerX)
        }
        windowBrushButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.09)
            make.height.equalToSuperview().multipliedBy(0.11)
            make.bottom.equalTo(windowTouchView.snp.top).offset(12)
            make.centerX.equalTo(windowTouchView.snp.centerX)
        }
    }
}
