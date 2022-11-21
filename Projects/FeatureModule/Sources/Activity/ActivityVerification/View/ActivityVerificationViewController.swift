//
//  ActivityVerificationViewController.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/16.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import ReactorKit
import AVFoundation

public class ActivityVerificationViewController: UIViewController, View {
    
    let mainView = ActivityVerificationView()
    
    lazy var imagePickerView = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .camera
        return picker
    }()

    public var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        reactor = ActivityVerificationReactor()
    }
    
    public func bind(reactor: ActivityVerificationReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: ActivityVerificationReactor) {
        mainView.exitButton.rx.tap
            .map { Reactor.Action.didTapExit }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.verificationButton.rx.tap
            .map { Reactor.Action.didTapVerification }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.retakeButton.rx.tap
            .map { Reactor.Action.didTapRetake }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        imagePickerView.rx.didFinishPickingMediaWithInfo
            .map { Reactor.Action.takePhoto($0[.editedImage] as? UIImage) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: ActivityVerificationReactor) {
        reactor.state
            .map { $0.isAppearImagePickerView }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let vself = self else { return }
                if $0 == true {
                    vself.present(vself.imagePickerView, animated: true) {
                        vself.mainView.initialHiddenGroup.forEach { $0.isHidden = false }
                        vself.mainView.laterHiddenGroup.forEach { $0.isHidden = true }
                    }
                } else {
                    vself.dismiss(animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.takenImage }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.mainView.cameraImageView.image = $0
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isComplete }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isExit }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
    }
}

extension ActivityVerificationViewController: UIImagePickerControllerDelegate {
}

extension ActivityVerificationViewController: UINavigationControllerDelegate {
}
