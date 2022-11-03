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
    var cancelButton = UIButton().then {
        $0.setImage(FeatureModuleAsset.nicknameDelete.image, for: .normal)
    }
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
        customRightView.addSubViews([cancelButton, checkNicknameButton])
        rightView = customRightView

        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }

        checkNicknameButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(cancelButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(30)
        }
    }
}
