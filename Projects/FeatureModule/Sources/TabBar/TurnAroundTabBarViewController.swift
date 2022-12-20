//
//  TurnAroundTabBarViewController.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

import RxSwift
import SnapKit

public class TurnAroundTabBarViewController: UITabBarController {

    public let turnAroundTabBar: TurnAroundTabBar = {
        let tabbar = TurnAroundTabBar()
        return tabbar
    }()

    public let backgroundView: UIView = {
        let view = UIView()
        view.layer.applySketchShadow(color: UIColor.black, alpha: 0.05, x: 0, y: -4, blur: 10, spread: 0)
        view.layer.cornerRadius = 20
        return view
    }()

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
        render()
        setUp()
        bind()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func render() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(turnAroundTabBar)
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
        turnAroundTabBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setUp() {
        tabBar.isHidden = true
        selectedIndex = 0
        let controllers = TurnAroundTabBarItem.allCases.map { $0.viewController }
        setViewControllers(controllers, animated: true)
    }

    func selectTabWith(index: Int) {
        self.selectedIndex = index
    }

    private func bind() {
        turnAroundTabBar.itemTapped
            .bind { [weak self] in
                guard let nvc = self?.viewControllers?[$0] as? UINavigationController else { return }
                nvc.popToRootViewController(animated: false)

                self?.selectTabWith(index: $0)

            }
            .disposed(by: disposeBag)
    }
}
