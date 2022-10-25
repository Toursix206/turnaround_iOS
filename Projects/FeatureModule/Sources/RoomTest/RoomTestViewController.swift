//
//  RoomTestViewController.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/10/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

public class RoomTestViewController: UIViewController {

    var mainView = RoomTestView()
    var disposeBag = DisposeBag()

    public override func loadView() {
        super.loadView()
        view = mainView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        mainView.deskAndChairTouchView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.mainView.deskAndChairBrushButton.isHidden.toggle()
            })
            .disposed(by: disposeBag)

        mainView.bedTouchView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.mainView.bedBrushButton.isHidden.toggle()
            })
            .disposed(by: disposeBag)

        mainView.windowTouchView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.mainView.windowBrushButton.isHidden.toggle()
            })
            .disposed(by: disposeBag)
    }
}
