//
//  RoomTestViewController.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/10/19.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
<<<<<<< HEAD:Projects/FeatureModule/Sources/Minseong/MinseongRoomTestViewController.swift
import ThirdPartyLib
=======
import SwiftUI

struct VCPreView:PreviewProvider {
    static var previews: some View {
        RoomTestViewController().toPreview()
    }
}
>>>>>>> [#13] FEAT: 브러쉬 버튼 배치:Projects/FeatureModule/Sources/Jihyeon/RoomTestViewController.swift

import RxSwift
import RxCocoa

public class MinseongRoomTestViewController: UIViewController {
    
//    var disposeBag = DisposeBag()

    var mainView = MinseongRoomTestView()

    public override func loadView() {
        super.loadView()
        view = mainView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
