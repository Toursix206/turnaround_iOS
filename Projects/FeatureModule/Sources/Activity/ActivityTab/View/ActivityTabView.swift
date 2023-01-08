//
//  ActivityTabView.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/12/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit

public final class ActivityTabView: UIView {
    
    // MARK: - UI Components
    
    private let topAreaBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.customFont(.body1SemiBold)
        $0.text = "생산적 활동"
    }
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 62, height: 90)
        $0.setCollectionViewLayout(layout, animated: true)
        $0.register(cell: ActivityCategoryCell.self)
    }
    
    lazy var tableView = UITableView(frame: .init(), style: .plain).then {
        $0.register(UINib(nibName: "ActivityListTableViewCell", bundle: nil), forCellReuseIdentifier: ActivityListTableViewCell.identifier)
    }
    
    // MARK: - initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layout
    
    private func render() {
        topAreaBackgroundView.addSubViews([titleLabel, categoryCollectionView])
        addSubViews([topAreaBackgroundView, tableView])
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
        
    }
}
