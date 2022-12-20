//
//  FirstProfileSettingViewController.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit
import RxGesture

public final class FirstProfileSettingViewController: UIViewController, ReactorKit.View {
    public typealias Reactor = FirstProfileSettingReactor

    public var disposeBag = DisposeBag()
    var mainView = FirstProfileSettingView()

    public override func loadView() {
        super.loadView()
        view = mainView
    }

    init(_ reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func bind(reactor: Reactor) {
        bindAction(reactor)
        bindState(reactor)
        bindCollectionView(reactor)
        bindTextField()
    }
}

extension FirstProfileSettingViewController {

    private func bindAction(_ reactor: Reactor) {

        rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        mainView.profileImageCollectionView.rx.itemSelected
            .map { Reactor.Action.selectProfileImage($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        mainView.nicknameTextfield.rx.text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.enterNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        mainView.nicknameTextfield.checkNicknameButton.rx.tap
            .map { Reactor.Action.didTapCheckNickname }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        mainView.signupButton.rx.tap
            .map { Reactor.Action.didTapSignup }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func bindState(_ reactor: Reactor) {

        reactor.state.map { $0.isSignupButtonValid }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.signupButton.rx.isEnabled)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isNicknameValid }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: updateNicknameChecked)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isCheckNickButtonHidden }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: updateCheckButton)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isErrorLabelHidden }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.errorMessageLabel.rx.isHidden)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isSignupSuccess }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: transferToTabBar)
            .disposed(by: disposeBag)
    }

    private func bindCollectionView(_ reactor: Reactor) {

        reactor.state.map { $0.cellImages }
            .distinctUntilChanged()
            .bind(to: mainView.profileImageCollectionView.rx.items) { (collectionView, row, element) -> UICollectionViewCell in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.className, for: IndexPath.init(row: row, section: 0)) as? ProfileImageCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.profileImageView.image = element.image
                return cell
            }
            .disposed(by: disposeBag)
    }

    private func bindTextField() {

        mainView.nicknameTextfield.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .subscribe { owner, _ in

                UIView.animate(withDuration: 0.5) {
                    owner.mainView.guideLabel.alpha = 0
                    owner.mainView.guideLabel.isHidden = true
                }
            }
            .disposed(by: disposeBag)

        mainView.nicknameTextfield.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .subscribe { owner, _ in
                UIView.animate(withDuration: 0.5) {
                    owner.mainView.guideLabel.isHidden = false
                    owner.mainView.guideLabel.alpha = 1
                }
            }
            .disposed(by: disposeBag)

        mainView.nicknameTextfield.delegate = self
    }

}

extension FirstProfileSettingViewController {

    private func updateNicknameChecked(_ isValid: Bool) {

        if isValid {
            mainView.errorMessageLabel.text = "인증완료"
            mainView.errorMessageLabel.textColor = .blue
        } else {
            mainView.errorMessageLabel.text = "중복된 닉네임이 존재합니다."
            mainView.errorMessageLabel.textColor = .red
        }
    }

    private func updateCheckButton(_ isHidden: Bool) {

        if isHidden {

            UIView.animate(withDuration: 0.5) {
                self.mainView.nicknameTextfield.checkView.alpha = 0
                self.mainView.nicknameTextfield.checkView.isHidden = true
            }

        } else {

            UIView.animate(withDuration: 0.5, animations: {
                self.mainView.nicknameTextfield.checkView.isHidden = false
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    self.mainView.nicknameTextfield.checkView.alpha = 1
                }
            }
        }
    }

    private func transferToTabBar(_ isSuccess: Bool) {
        let tabBarVC = TurnAroundTabBarViewController()
        changeRootViewController(to: tabBarVC)
    }
}

extension FirstProfileSettingViewController: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text,
              let stringRange = Range(range, in: text) else {return false}

        let changeText = text.replacingCharacters(in: stringRange, with: string)

        return changeText.count <= 8
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
