//
//  BottomSheet.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/25.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

open class BottomSheetViewController: UIViewController {
    
    private let dimmedView: UIView = UIView().then {
        $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
    }
    
    private let bottomSheetView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.backgroundColor = .white
    }
    
    private var sheetHeight: CGFloat = 0
    
    private lazy var bottomSheetPanStartingY: CGFloat = self.bottomSheetView.frame.origin.y
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    init(sheetHeight: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        self.sheetHeight = sheetHeight
        self.modalPresentationStyle = .overFullScreen
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        render()
        showBottomSheet()
        configUI()
        setPanGesture()
    }
    
    func configUI() {
        dimmedView.rx.tapGesture()
            .when(.ended)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.hideBottomSheetAndGoBack()
            })
            .disposed(by: disposeBag)
    }
    
    func render() {
        view.addSubViews([dimmedView, bottomSheetView])
        
        dimmedView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        bottomSheetView.snp.makeConstraints { [weak self] in
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(sheetHeight).constraint
        }
    }
    
    private func showBottomSheet() {
        let viewHeight = view.frame.maxY
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.bottomSheetView.snp.updateConstraints {
                $0.top.equalTo(viewHeight - self.sheetHeight)
            }
            self.bottomSheetView.frame.origin.y = viewHeight - self.sheetHeight
            self.dimmedView.alpha = 0.7
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetView.snp.updateConstraints {
            $0.top.equalTo(safeAreaHeight + bottomPadding)
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }.addCompletion { position in
            if position == .end {
                if self.presentingViewController != nil {
                    self.dismiss(animated: false)
                }
            }
        }
    }
    
    private func setPanGesture() {
        view.rx.panGesture()
            .when(.ended)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let vself = self else { return }
                if vself.bottomSheetView.frame.origin.y < vself.view.frame.maxY - (vself.sheetHeight / 2) {
                    vself.showBottomSheet()
                } else {
//                    print("go")
                    vself.hideBottomSheetAndGoBack()
                }
            }).disposed(by: disposeBag)
        
        view.rx.panGesture()
            .when(.began)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.bottomSheetPanStartingY = self?.bottomSheetView.frame.origin.y ?? 0
            }).disposed(by: disposeBag)
        
        view.rx.panGesture()
            .when(.changed)
            .observe(on:MainScheduler.instance)
            .bind(onNext: { [weak self] event in
                let transition = event.translation(in: self?.view)
                if transition.y + (self?.bottomSheetPanStartingY ?? 0) > (self?.view.frame.maxY ?? 0) - (self?.sheetHeight ?? 0) {
                    self?.bottomSheetView.frame.origin.y = (self?.bottomSheetPanStartingY ?? 0) + transition.y
                }
            })
            .disposed(by: disposeBag)
    }
}
