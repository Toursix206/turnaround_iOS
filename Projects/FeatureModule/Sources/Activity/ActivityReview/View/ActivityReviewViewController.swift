//
//  ActivityReviewViewController.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/18.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import RxGesture

public final class ActivityReviewViewController: UIViewController, View {
    
    let mainView = ActivityReviewView()
    
    public var disposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = ActivityReviewReactor()
    }
    
    public func bind(reactor: ActivityReviewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ActivityReviewReactor) {
        
        mainView.ratingSlider.rx.value
            .map { Reactor.Action.changeRatingValue($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.ratingSlider.rx.tapGesture()
            .when(.began)
            .map { [weak self] in
                let touchLocationX = Float($0.location(in: self?.mainView).x)
                let sliderOriginX = Float(self?.mainView.ratingSlider.frame.origin.x ?? 0.0)
                let sliderWidth = Float(self?.mainView.ratingSlider.frame.width ?? 200.0)
                let maxValue = Float(self?.mainView.ratingSlider.maximumValue ?? 5.0)
                return Reactor.Action.changeRatingValue(floor(touchLocationX - sliderOriginX) * maxValue / sliderWidth)
            }
            .debug()
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        mainView.textView.rx.text
            .map { Reactor.Action.editReviewText($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ActivityReviewReactor) {
        reactor.state
            .map { $0.reviewText }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.mainView.textCountLabel.text = "\($0.count)/500"
            }).disposed(by: disposeBag)
        
        reactor.state
            .map { $0.ratingValue }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.mainView.ratingLabel.text = "별점 등록 (\($0)/5)"
                self?.mainView.ratingSlider.setValue(Float($0), animated: false)
                
                for index in 0...5 {
                    if let starImage = self?.mainView.viewWithTag(index) as? UIImageView {
                        if index <= $0 {
                            starImage.image = FeatureModuleAsset.starOn.image
                        } else {
                            starImage.image = FeatureModuleAsset.star.image
                        }
                    }
                }
                
            }).disposed(by: disposeBag)
    }
}
