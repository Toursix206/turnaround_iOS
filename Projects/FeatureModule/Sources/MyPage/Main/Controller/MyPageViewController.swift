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

public class MyPageViewController: UIViewController, View {
    
    public typealias Reactor = MyPageReactor
    
    public var disposeBag = DisposeBag()
    
    var mainView = MyPageView()
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<MyPageTableViewSectionModel> { _, tableView, indexPath, sectionItems in
        
        switch sectionItems {
        case .defaultCell(let reactor):
            guard let cell = self.mainView.tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.className, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
            cell.reactor = reactor
            return cell
        }
    }
    
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
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: FeatureModuleAsset.ColorAsset.gray10,
            .font: UIFont.customFont(.body1SemiBold)
        ]
        navigationItem.title = "마이페이지"
    }
    
    public func bind(reactor: MyPageReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
}

extension MyPageViewController {
    private func bindAction(_ reactor: Reactor) {
        
        self.mainView.tableView.rx.itemSelected
            .map { Reactor.Action.cellSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
    }
    
    private func bindState(_ reactor: Reactor) {
        reactor.state.map { $0.selectedIndexPath }
            .compactMap { $0 }
            .subscribe { [weak self] indexPath in
                guard let self = self else {
                    return
                }
                self.mainView.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sections }
            .compactMap { $0 }
            .bind(to:self.mainView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
