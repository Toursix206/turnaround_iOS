//
//  MyPageViewController.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxDataSources

public class MyPageViewController: UIViewController, View, UIScrollViewDelegate {
    
    public typealias Reactor = MyPageReactor
    
    public var disposeBag = DisposeBag()
    
    var mainView = MyPageView()
    
    var tableViewItemObservable = Observable.of(MyPageTableViewCellModel.slideContents)
    
//    lazy var dataSource = RxTableViewSectionedReloadDataSource<MyPageTableViewSectionModel> { _, tableView, indexPath, sectionItems in
//
//        switch sectionItems {
//        case .defaultCell(let reactor):
//            guard let cell = self.mainView.tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.className, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
//            cell.reactor = reactor
//            return cell
//        }
//    }
    
    public init(_ reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: FeatureModuleAsset.ColorAsset.gray10.color,
            .font: UIFont.customFont(.body1SemiBold)
        ]
        navigationItem.title = "마이페이지"
    }
    
    public func bind(reactor: MyPageReactor) {
        bindAction(reactor)
        bindState(reactor)
        bindView()
    }
    
}

extension MyPageViewController {
    private func bindAction(_ reactor: Reactor) {
        
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear(self.mainView.userProfileLabel.text, self.mainView.userProfileImageView.image?.description, Int(self.mainView.earningPointCountLabel.text!))}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.mainView.tableView.rx.itemSelected
            .map { Reactor.Action.cellSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
    }
    
    private func bindState(_ reactor: Reactor) {
        reactor.state.map { $0.selectedIndexPath }
            .compactMap { $0 }
            .subscribe (onNext: { [weak self] indexPath in
                guard let self = self else {
                    return
                }
                self.mainView.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.nickname }
            .distinctUntilChanged()
            .bind(to: mainView.userProfileLabel.rx.text)
            .disposed(by: disposeBag)
        
//        reactor.state.map { $0.profileImage }
//            .distinctUntilChanged()
//            .bind()
//            .disposed(by: disposeBag)
        
        reactor.state.map { "\(String(describing: $0.point))" }
            .distinctUntilChanged()
            .bind(to: mainView.earningPointCountLabel.rx.text)
            .disposed(by: disposeBag)
        
//        reactor.state.map { $0.sections }
//            .compactMap { $0 }
//            .bind(to:self.mainView.tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
    }
    
    private func bindView() {
        
        tableViewItemObservable
            .bind(to: mainView.tableView.rx.items(cellIdentifier: MyPageTableViewCell.className, cellType: MyPageTableViewCell.self)) { indexPath, elements, cell in
                cell.cellTitleLabel.text = elements.title
                cell.iconView.image = elements.image
            }
            .disposed(by: disposeBag)
        
        mainView.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
//        slideObservable
//            .bind(to: (introView.introCollectionView.rx.items(
//                cellIdentifier: IntroCollectionViewCell.className,
//                cellType: IntroCollectionViewCell.self))
//            ){ indexPath, content, cell in
//                cell.slideImageView.image = content.image
//                cell.slideDescriptionLabel.text = content.description
//            }
//            .disposed(by: disposeBag)
//
//        introView.introCollectionView.rx.setDelegate(self)
//            .disposed(by: disposeBag)
    }
    
//    private func stringToImage(_ string: Int) -> String {
//
//        var string = ""
//
//        if num == 1 {
//            string = "ONE"
//        } else if num == 2 {
//            string = "TWO"
//        } else {
//            string = "THREE"
//        }
//
//        return string
//    }
}
