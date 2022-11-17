//
//  ProfileImageCollectionViewCell.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class ProfileImageCollectionViewCell: UICollectionViewCell {
    var profileImageView = UIImageView()

    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = UIColor(red: 144/255, green: 92/255, blue: 1, alpha: 0.3)
                contentView.layer.borderColor = UIColor.black.cgColor
                contentView.layer.borderWidth = 3
            } else {
                contentView.backgroundColor = .systemGray6
                contentView.layer.borderWidth = 0
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setup()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileImageCollectionViewCell {
    private func setup() {
        profileImageView.clipsToBounds = true
        contentView.backgroundColor = .systemGray6
        contentView.makeRounded(cornerRadius: self.contentView.frame.width/2)
    }

    private func render() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(5)
        }
    }
}
