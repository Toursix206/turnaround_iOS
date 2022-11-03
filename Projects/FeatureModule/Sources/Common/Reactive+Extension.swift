//
//  Reactive+Extension.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UIViewController {
  public var viewWillAppear: Observable<[Any]> {
    return sentMessage(#selector(UIViewController.viewWillAppear(_:)))
  }
}
