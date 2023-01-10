//
//  ActivityTabViewController.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit
import RxDataSources

final class ActivityTabViewController: UIViewController, View {
    
    typealias Reactor = ActivityTabReactor
    
    var disposeBag = DisposeBag()
    var mainView = ActivityTabView()
    
    private lazy var tableViewDataSource = RxTableViewSectionedReloadDataSource<ActivityTableViewSectionModel> { dataSource, tableView, indexPath, item -> UITableViewCell in
        switch item {
        case .defaultCell(let reactor):
            guard let cell = self.mainView.tableView.dequeueReusableCell(withIdentifier: ActivityListTableViewCell.identifier, for: indexPath) as? ActivityListTableViewCell else { return UITableViewCell() }
            cell.reactor = reactor
            return cell
        }
    }
    
    // MARK: - initializer
    
    public init(_ reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    func bind(reactor: ActivityTabReactor) {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = nil
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: ActivityTabReactor) {
        rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: ActivityTabReactor) {
        reactor.state.compactMap { $0.activities }
            .bind(to: mainView.tableView.rx.items(dataSource: self.tableViewDataSource))
            .disposed(by: disposeBag)
    }
}

extension ActivityTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
