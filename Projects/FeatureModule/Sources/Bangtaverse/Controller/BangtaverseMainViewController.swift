//
//  BangtaverseMainViewController.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

class BangtaverseMainViewController: UIViewController {

    var mainView = BangtaverseMainView()

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}
