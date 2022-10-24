//
//  RoomTestViewController.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/10/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

public class RoomTestViewController: UIViewController {

    var mainView = RoomTestView()

    public override func loadView() {
        super.loadView()
        view = mainView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
