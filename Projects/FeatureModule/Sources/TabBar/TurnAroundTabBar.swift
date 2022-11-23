//
//  TurnAroundTabBar.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

import SnapKit

final public class TurnAroundTabBar: UIStackView {
    var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }

    private lazy var itemViews: [TurnAroundTabBarItemView] = [homeItemView, bangtaverseItemView, activityItemView, mypageItemView]

    private let homeItemView: TurnAroundTabBarItemView = {
        let view =  TurnAroundTabBarItemView(item: .home, index: 0)
        view.clipsToBounds = true
        return view
    }()

    private let bangtaverseItemView: TurnAroundTabBarItemView = {
        let view = TurnAroundTabBarItemView(item: .bangtaverse, index: 1)
        view.clipsToBounds = true
        return view
    }()

    private let activityItemView: TurnAroundTabBarItemView = {
        let view = TurnAroundTabBarItemView(item: .activity, index: 2)
        view.clipsToBounds = true
        return view
    }()

    private let mypageItemView: TurnAroundTabBarItemView = {
        let view = TurnAroundTabBarItemView(item: .mypage, index: 3)
        view.clipsToBounds = true
        return view
    }()

    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()

    init() {
        super.init(frame: .zero)
        render()
        bind()

        selectItem(index: 0)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {

        axis = .horizontal
        distribution = .fillEqually
        alignment = .center

        layer.cornerRadius = 20
        backgroundColor = .white

        addArrangedSubviews(homeItemView, bangtaverseItemView, activityItemView, mypageItemView)

        itemViews.forEach { view in
            view.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        }

    }

    public func selectItem(index: Int) {
        itemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
    }

    private func bind() {
        homeItemView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.homeItemView.animateClick {
                    owner.selectItem(index: 0)
                }
            })
            .disposed(by: disposeBag)

        bangtaverseItemView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.bangtaverseItemView.animateClick {
                    owner.selectItem(index: 1)
                }
            })
            .disposed(by: disposeBag)

        activityItemView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.activityItemView.animateClick {
                    owner.selectItem(index: 2)
                }
            })
            .disposed(by: disposeBag)

        mypageItemView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.mypageItemView.animateClick {
                    owner.selectItem(index: 3)
                }
            })
            .disposed(by: disposeBag)

    }
}
