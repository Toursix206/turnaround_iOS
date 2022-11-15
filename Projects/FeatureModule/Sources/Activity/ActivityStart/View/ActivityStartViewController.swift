//
//  ActivityStartViewController.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/14.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class ActivityStartViewController: UIViewController {
    
    let mainView = ActivityStartView()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
    
    private func bindAction() {
        mainView.exitButton.rx.tap
            .asDriver().drive(onNext: {
                
            })
            .disposed(by: disposeBag)
        
        mainView.startButton.rx.tap
            .asDriver().drive(onNext: {
                
            })
            .disposed(by: disposeBag)
    }
    
}
