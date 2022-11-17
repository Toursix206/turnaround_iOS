//
//  NicknameTextField.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameTextField: UITextField {

    var disposeBag = DisposeBag()

    var customRightView = UIView()

    var stackView = UIStackView().then {
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.axis = .horizontal
        $0.spacing = 8
    }

    var cancelView = UIView()
    var cancelButton = UIButton().then {
        $0.setImage(FeatureModuleAsset.nicknameDelete.image, for: .normal)
    }

    var checkView = UIView()
    var checkNicknameButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 14)
        $0.makeRounded(cornerRadius: 15)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setup()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NicknameTextField {
    private func binding() {
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: self.cancelAllText)
            .disposed(by: disposeBag)
    }

    private func cancelAllText() { self.text = "" }
}

extension NicknameTextField {
    private func setup() {
        backgroundColor = .systemGray6
        makeRounded(cornerRadius: 8)
        font = UIFont(font: FeatureModuleFontFamily.Pretendard.regular, size: 16)
        placeholder = "턴어라운드"
        addLeftPadding(16)
        clearButtonMode = .whileEditing
        rightViewMode = .whileEditing
    }

    private func render() {
        customRightView.addSubview(stackView)
        stackView.addArrangedSubviews(cancelView, checkView)
        cancelView.addSubview(cancelButton)
        checkView.addSubview(checkNicknameButton)
        rightView = customRightView

        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.lessThanOrEqualTo(200)
        }

        cancelView.snp.makeConstraints { make in
            make.width.equalTo(20)
        }

        checkView.snp.makeConstraints { make in
            make.width.equalTo(72)
        }

        cancelButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(20)
        }

        checkNicknameButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(30)
        }
    }
}
