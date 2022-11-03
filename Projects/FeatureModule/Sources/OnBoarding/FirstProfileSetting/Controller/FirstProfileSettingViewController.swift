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

    public var disposeBag = DisposeBag()
    var mainView = FirstProfileSettingView()

    public override func loadView() {
        super.loadView()
        view = mainView
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        reactor = FirstProfileSettingReactor()
    }

    public func bind(reactor: FirstProfileSettingReactor) {

        rx.viewWillAppear
          .map { _ in Reactor.Action.viewWillAppear }
          .bind(to: reactor.action)
          .disposed(by: disposeBag)

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
}
