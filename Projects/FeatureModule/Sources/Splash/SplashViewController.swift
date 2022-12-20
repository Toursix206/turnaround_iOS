//
//  SplashViewController.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

import SnapKit
import Then

import ReactorKit

public final class SplashViewController: UIViewController, ReactorKit.View {
    public typealias Reactor = SplashReactor
    public var disposeBag: DisposeBag = DisposeBag()

    private let titleLabel = UILabel().then {
        $0.textColor = UIColor.white
        $0.font = UIFont.customFont(.H1Bold)
        $0.text = "Turn\nAround"
        $0.numberOfLines = 2
    }

    public init(_ reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        render()
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func render() {
        view.backgroundColor = .darkGray
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension SplashViewController {
    public func bind(reactor: Reactor) {
        bindAction(reactor)
        bindState(reactor)
    }

    func bindAction(_ reactor: Reactor) {
        rx.viewWillAppear
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(_ reactor: Reactor) {

        reactor.state.map { $0.isUser }
            .compactMap { $0 }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: self.transferToTabBar)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isLoginFlow }
            .compactMap { $0 }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: self.transferToOnboarding)
            .disposed(by: disposeBag)
    }
}

extension SplashViewController {
    private func transferToTabBar(_ isUser: Bool) {
        let tabBarVC = TurnAroundTabBarViewController()
        changeRootViewController(to: tabBarVC)
    }

    private func transferToOnboarding(_ isLoginFlow: Bool) {

        let serviceProvider = ServiceProvider()
        let reactor = IntroReactor(provider: serviceProvider)
        let vc = IntroViewController(reactor)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.view.window?.rootViewController = vc
    }
}
