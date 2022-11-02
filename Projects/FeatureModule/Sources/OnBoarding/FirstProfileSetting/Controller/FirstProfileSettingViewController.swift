//
//  FirstProfileSettingViewController.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

class FirstProfileSettingViewController: UIViewController {

    var mainView = FirstProfileSettingView()

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
