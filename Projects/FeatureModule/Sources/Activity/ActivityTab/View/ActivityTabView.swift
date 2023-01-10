//
//  ActivityTabView.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import Then

public final class ActivityTabView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.customFont(.body1SemiBold)
        $0.text = "생산적 활동"
    }
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 62, height: 90)
        $0.setCollectionViewLayout(layout, animated: true)
        $0.register(cell: ActivityCategoryCell.self)
    }
    
    private let tableViewBackgroundView = UIView().then {
        $0.backgroundColor = FeatureModuleAsset.ColorAsset.gray2.color
    }
    
    lazy var tableView = UITableView(frame: .init(), style: .plain).then {
        $0.separatorStyle = .none
        $0.register(ActivityListTableViewCell.self, forCellReuseIdentifier: ActivityListTableViewCell.identifier)
        $0.backgroundColor = UIColor.clear
        $0.delegate = nil
        $0.dataSource = nil
    }
    
    // MARK: - initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layout
    
    private func render() {
        addSubViews([titleLabel, categoryCollectionView,tableViewBackgroundView])

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.height.equalTo(90)
        }
        
        tableViewBackgroundView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(197)
            $0.bottom.equalToSuperview()
        }
        
        tableViewBackgroundView.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalToSuperview()
        }
    }
}
