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

final class SplashViewController: UIViewController, ReactorKit.View {
    typealias Reactor = SplashReactor
    var disposeBag: DisposeBag = DisposeBag()

    private let titleLabel = UILabel().then {
        $0.textColor = UIColor.white
        $0.font = UIFont.customFont(.H1Bold)
        $0.text = "Turn\nAround"
        $0.numberOfLines = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
