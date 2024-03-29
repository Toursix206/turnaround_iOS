//
//  TurnAroundTabBarItemView.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

final class TurnAroundTabBarItemView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.captionRegular)
        label.textAlignment = .center
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private let containerView = UIView()

    private let item: TurnAroundTabBarItem
    let index: Int

    var isSelected = false {
        didSet {
            animateItems()
        }
    }

    init(item: TurnAroundTabBarItem, index: Int) {
        self.item = item
        self.index = index
        super.init(frame: .zero)

        titleLabel.text = item.name
        iconImageView.image = isSelected ? item.selectedIcon : item.unselectedIcon

        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(iconImageView)

        containerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
        }
    }

    private func animateItems() {
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }

            self.titleLabel.textColor = self.isSelected ? FeatureModuleAsset.ColorAsset.gray10.color : FeatureModuleAsset.ColorAsset.gray5.color
            self.titleLabel.font = self.isSelected ? UIFont.customFont(.captionSemiBold) : UIFont.customFont(.captionRegular)
        }

        UIView.transition(
            with: iconImageView,
            duration: 0.4,
            options: .transitionCrossDissolve) { [weak self] in

                guard let self = self else { return }
                self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.unselectedIcon
            }
    }

    func animateClick(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in completion() }
        }
    }
}
