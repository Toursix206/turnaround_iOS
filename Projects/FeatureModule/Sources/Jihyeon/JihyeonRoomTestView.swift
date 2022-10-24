//
//  RoomTestView.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/10/19.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

//import UIKit
//import SnapKit
//import Then
//
//import ThirdPartyLib
//import ServiceModule
//
//import RxSwift
//import RxGesture
//
//enum DirtyLevel {
//    case clean, dirty
//}
//
//class RoomTestView: UIView {
//    
//    var disposeBag = DisposeBag()
//
//    //var dirtyLevel: DirtyLevel = .dirty
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//        render()
//        bind()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var roomView = UIView()
//
//    var emptyRoomImageView = UIImageView().then {
//        $0.image = FeatureModuleAsset.roomWithHole.image
//    }
//
//    var deskAndChairImageView = UIImageView().then {
//        $0.image = FeatureModuleAsset.deskAndChair.image
//    }
//    var bedImageView = UIImageView().then {
//        $0.image = FeatureModuleAsset.bed.image
//    }
//    var windowImageView = UIImageView().then {
//        $0.image = FeatureModuleAsset.transparentWindow.image
//    }
//    
//    var deskAndChairBrushView = UIImageView().then {
//        $0.image = FeatureModuleAsset.brush.image
//    }
//    
//    var bedBrushView = UIImageView().then {
//        $0.image = FeatureModuleAsset.brush.image
//    }
//    
//    var windowBrushView = UIImageView().then {
//        $0.image = FeatureModuleAsset.brush.image
//    }
//
//    var deskAndChairTouchView = UIView()
//    var bedTouchView = UIView()
//    var windowTouchView = UIView()
//
//    private func setup() {
//        deskAndChairTouchView.backgroundColor = .red
//        windowTouchView.backgroundColor = .yellow
//        bedTouchView.backgroundColor = .blue
//    }
//
//    private func render() {
//
//        addSubview(roomView)
//        [emptyRoomImageView,
//         bedImageView, deskAndChairImageView, windowImageView,
//        bedTouchView, deskAndChairTouchView, windowTouchView, deskAndChairBrushView, bedBrushView, windowBrushView].forEach { roomView.addSubview($0) }
//
//        roomView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(roomView.snp.width)
//            make.center.equalToSuperview()
//        }
//
//        emptyRoomImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        [bedImageView, deskAndChairImageView, windowImageView].forEach {
//            $0.snp.makeConstraints { make in
//                make.center.equalToSuperview()
//                make.size.equalToSuperview()
//            }
//        }
//
//        bedTouchView.snp.makeConstraints { make in
//            make.height.equalToSuperview().multipliedBy(0.2)
//            make.width.equalToSuperview().multipliedBy(0.3)
//            make.centerX.equalToSuperview().multipliedBy(1.2)
//            make.centerY.equalToSuperview().multipliedBy(1.2)
//        }
//
//        deskAndChairTouchView.snp.makeConstraints { make in
//            make.height.equalToSuperview().multipliedBy(0.2)
//            make.width.equalToSuperview().multipliedBy(0.3)
//            make.centerX.equalToSuperview().multipliedBy(0.6)
//            make.centerY.equalToSuperview().multipliedBy(1.2)
//        }
//
//        windowTouchView.snp.makeConstraints { make in
//            make.height.equalToSuperview().multipliedBy(0.2)
//            make.width.equalToSuperview().multipliedBy(0.3)
//            make.centerX.equalToSuperview().multipliedBy(0.6)
//            make.centerY.equalToSuperview().multipliedBy(0.7)
//        }
//        
//        deskAndChairBrushView.snp.makeConstraints { make in
//            make.height.equalToSuperview().multipliedBy(0.1)
//            make.width.equalToSuperview().multipliedBy(0.1)
//            make.centerX.equalToSuperview().multipliedBy(0.8)
//            make.centerY.equalToSuperview().multipliedBy(0.95)
//        }
//        
//        windowBrushView.snp.makeConstraints { make in
//            make.height.equalToSuperview().multipliedBy(0.1)
//            make.width.equalToSuperview().multipliedBy(0.1)
//            make.centerX.equalToSuperview().multipliedBy(0.8)
//            make.centerY.equalToSuperview().multipliedBy(0.4)
//        }
//        
//        bedBrushView.snp.makeConstraints { make in
//            make.height.equalToSuperview().multipliedBy(0.1)
//            make.width.equalToSuperview().multipliedBy(0.1)
//            make.centerX.equalToSuperview().multipliedBy(1.3)
//            make.centerY.equalToSuperview().multipliedBy(0.9)
//        }
//        
//        deskAndChairBrushView.isHidden = true
//        bedBrushView.isHidden = true
//        windowBrushView.isHidden = true
//        
//    }
//    
//    private func bind() {
//        deskAndChairTouchView.rx
//            .tapGesture()
//            .when(.recognized)
//            .subscribe(onNext: { _ in
//                self.deskAndChairBrushView.isHidden.toggle()
//            })
//            .disposed(by: disposeBag)
//
//        bedTouchView.rx
//            .tapGesture()
//            .when(.recognized)
//            .subscribe(onNext: { _ in
//                self.bedBrushView.isHidden.toggle()
//            })
//            .disposed(by: disposeBag)
//
//        windowTouchView.rx
//            .tapGesture()
//            .when(.recognized)
//            .subscribe(onNext: { _ in
//                self.windowBrushView.isHidden.toggle()
//            })
//            .disposed(by: disposeBag)
//    }
//    
//}
