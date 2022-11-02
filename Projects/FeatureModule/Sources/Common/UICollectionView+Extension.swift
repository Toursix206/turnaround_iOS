//
//  UICollectionView+Extension.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/01.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cell: T.Type, forCellWithReuseIdentifier reuseIdentifier: String = T.className) {
        register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}
