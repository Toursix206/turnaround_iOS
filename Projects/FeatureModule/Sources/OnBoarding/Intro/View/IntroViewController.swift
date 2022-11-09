//
//  IntroViewController.swift
//  FeatureModuleTests
//
//  Created by 강민성 on 2022/10/30.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Then
import ReactorKit
import KakaoSDKAuth
import ServiceModule

public class IntroViewController: UIViewController, View {
    
    public typealias Reactor = IntroReactor
    
    public var disposeBag = DisposeBag()
    
    var introView = IntroView()
    
    
    var slideObservable = Observable.of(IntroModel.slideContents)
    
    var introCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 360, height: 408)
        layout.minimumLineSpacing = 0
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.register(cell: IntroCollectionViewCell.self)
    }
    
    var currentPage = 0 {
        didSet{
            introView.pageControl.currentPage = currentPage
            if currentPage == 2 {
                //                introView.signInWithAppleButtonTemp.isHidden = false
                introView.signInWithKakakoButton.isHidden = false
                introView.nextButton.isHidden = true
                
            }
            else {
                //                introView.signInWithAppleButtonTemp.isHidden = true
                introView.signInWithKakakoButton.isHidden = true
                introView.nextButton.isHidden = false
            }
        }
    }
    
    public override func loadView() {
        super.loadView()
        view = introView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(introCollectionView)
        render()
        bindViews()
        
    }
    
    public func bind(reactor: IntroReactor) {
        
        self.rx.viewDidLoad
            .map { Reactor.Action.isKakaoAvailable }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.introView.signInWithKakakoButton.rx.tap
            .map{ Reactor.Action.tappedKakaoSignUp }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.authState }
            .distinctUntilChanged()
            .filter { $0 == AuthState.authenticated }
            .subscribe(onNext: { [weak self] authState in
                print("AuthState is \(authState)")
                switch authState {
                case .authenticated:
                    // 서버로 FCM토큰, authType, accessToekn 넘겨주기
                    print("WTF")
                    
                case .unAuthenticated:
                    print("FATAL ERROR: THIS SHOULD BE NOT HAPPENNING")
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.loginState }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] loginState in
                print("LoginState is \(loginState)")
                switch loginState {
                case .logout:
                    print("ERROR: ALREADY LOGGED OUT")
                    
                case .unregistered:
                    print("ERROR: NOT REGISTERED")
                    
                case .login:
                    // 프로필 설정 뷰로 옮기기
                    print("WTF")
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func bindViews() {
        
        introView.nextButton.rx.tap
            .subscribe(onNext: {
                if self.currentPage == 2 {
                    // 프로필 설정 VC 로 넘어가기
                }
                else {
                    self.currentPage += 1
                    let indexPath = IndexPath(item: self.currentPage, section: 0)
                    self.introCollectionView.isPagingEnabled = false
                    self.introCollectionView.scrollToItem(
                        at: indexPath,
                        at: .centeredHorizontally,
                        animated: true)
                    self.introCollectionView.isPagingEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        slideObservable
            .bind(to: (introCollectionView.rx.items(
                cellIdentifier: IntroCollectionViewCell.className,
                cellType: IntroCollectionViewCell.self))
            ){ indexPath, content, cell in
                cell.slideImageView.image = content.image
                cell.slideDescriptionLabel.text = content.description
            }
            .disposed(by: disposeBag)
        
        introCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func render() {
        introCollectionView.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(408)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(96)
        }
        
        
    }
    
}

extension IntroViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
