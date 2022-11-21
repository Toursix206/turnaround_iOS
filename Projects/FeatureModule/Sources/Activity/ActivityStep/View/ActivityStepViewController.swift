//
//  ActivityStepViewController.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/15.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit

final public class ActivityStepViewController: UIViewController, View {
    
    public var disposeBag = DisposeBag()
    
    var mainView = ActivityStepView()
    
    // MARK: - Life Cycle
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = ActivityStepReactor()
    }
    
    public func bind(reactor: ActivityStepReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ActivityStepReactor) {
        mainView.exitButton.rx.tap
            .map { Reactor.Action.didTapCancel }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.completeButton.rx.tap
            .map { Reactor.Action.didTapComplete }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ActivityStepReactor) {
        reactor.state
            .map { NSAttributedString(string: $0.stepLabelText, attributes: [.font: FeatureModuleFontFamily.Pretendard.semiBold.font(size: 14),
                                                                             .foregroundColor: UIColor.white])}
            .bind(to: mainView.stepLabel.rx.attributedTitle(for: .normal))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.titleText }
            .bind(to: mainView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.subtitleText }
            .bind(to: mainView.subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.progressRatio }
            .bind(to: mainView.progressBar.rx.progress)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { "\($0.currentStep.rawValue)/4" }
            .bind(to: mainView.stepIndicatorLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.image }
            .bind(to: mainView.imageView.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { NSAttributedString(string: $0.buttonText, attributes: [.font: FeatureModuleFontFamily.Pretendard.semiBold.font(size: 16)])}
            .bind(to: mainView.completeButton.rx.attributedTitle(for: .normal))
            .disposed(by: disposeBag)
    }
}
