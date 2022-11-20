//
//  FirstProfileSettingView.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class FirstProfileSettingView: UIView {

    enum Size {
        static let screenHeight = UIScreen.main.bounds.height
        static let screenWidth = UIScreen.main.bounds.width
        static let sidePadding = CGFloat(22)
        static let itemSpacing = CGFloat(4)
        static let itemWidth = (screenWidth - sidePadding * 2 - itemSpacing * 2) / 3
        static let profileImageItemSize = CGSize(width: itemWidth, height: itemWidth)
        static let textfieldHeight = 60
        static let buttonHeight = 56
    }

    let contentStackView = UIStackView().then {
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.spacing = 30
    }

    var guideLabel = UILabel().then {
        $0.font = UIFont(font: FeatureModuleFontFamily.Pretendard.bold, size: 20)
        $0.text = "프로필과 닉네임을\n설정해주세요!"
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
        $0.lineBreakStrategy = .hangulWordPriority
    }

    let inputStackView = UIStackView().then {
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        $0.spacing = 30
    }

    private let profileView = UIView()
    private let profileLabel = UILabel().then { $0.text = "프로필" }
    var profileImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Size.itemSpacing
        layout.itemSize = Size.profileImageItemSize
        $0.setCollectionViewLayout(layout, animated: true)
        $0.register(cell: ProfileImageCollectionViewCell.self)
    }

    private let nicknameView = UIView()
    private let nicknameLabel = UILabel().then { $0.text = "닉네임" }
    var nicknameTextfield = NicknameTextField()

    var errorMessageLabel = UILabel().then {
        $0.isHidden = true
        $0.text = "."
    }

    var signupButton = UIButton(configuration: UIButton.Configuration.filled()).then {
        $0.makeRounded(cornerRadius: 14)
        let titleAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 16)!
        ]
        $0.configuration?.attributedTitle = AttributedString(
          "가입하기",
          attributes: AttributeContainer(titleAttr)
        )

        $0.configurationUpdateHandler = { btn in
          switch btn.state {
          case .disabled:
              btn.configuration?.baseBackgroundColor = .lightGray
              btn.configuration?.baseForegroundColor = .gray
          case .normal:
              btn.configuration?.baseBackgroundColor = .black
              btn.configuration?.baseForegroundColor = .white
          default:
            break
          }
        }

        $0.isEnabled = false
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

extension FirstProfileSettingView {
    private func setup() {
        [profileLabel, nicknameLabel, errorMessageLabel].forEach {
            $0.font = UIFont(font: FeatureModuleFontFamily.Pretendard.regular, size: 16)
        }
    }

    private func render() {
        addSubViews([contentStackView, signupButton])
        contentStackView.addArrangedSubviews(guideLabel, inputStackView)
        inputStackView.addArrangedSubviews(profileView, nicknameView)
        profileView.addSubViews([profileLabel, profileImageCollectionView])
        nicknameView.addSubViews([nicknameLabel, nicknameTextfield, errorMessageLabel])

        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(Size.sidePadding)
        }

        profileLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        profileImageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Size.itemWidth)
        }

        nicknameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        nicknameTextfield.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Size.textfieldHeight)
        }
        errorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextfield.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview().inset(4)
        }

        signupButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(Size.buttonHeight)
        }
    }
}
