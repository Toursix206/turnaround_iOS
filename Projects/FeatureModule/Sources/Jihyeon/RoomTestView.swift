//
//  RoomTestView.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/10/19.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import Then

class RoomTestView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        $0.image = FeatureModuleAsset.window.image
    }

    private func render() {

        addSubview(roomView)
        [emptyRoomImageView, bedImageView, deskAndChairImageView, windowImageView].forEach { roomView.addSubview($0) }

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
    }
}
