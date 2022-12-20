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
    private let appleLoginManager = AppleOAuthManager()
    private let kakaoLoginManager = KakaoOAuthManager()
    private var signInRelay = PublishRelay<(String?, Error?)>()

    var introView = IntroView()
    
    var slideObservable = Observable.of(IntroModel.slideContents)

    var currentPage = 0 {
        didSet{
            introView.pageControl.currentPage = currentPage
            if currentPage == 2 {
                introView.signInWithAppleButton.isHidden = false
                introView.signInWithKakakoButton.isHidden = false
                introView.nextButton.isHidden = true
                
            }
            else {
                introView.signInWithAppleButton.isHidden = true
                introView.signInWithKakakoButton.isHidden = true
                introView.nextButton.isHidden = false
            }
        }
    }
    
    public override func loadView() {
        super.loadView()
        view = introView
    }

    public init(_ reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        configureAppleSignIn()
        configureKakaoSignIn()
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func bind(reactor: Reactor) {
        bindAction(reactor)
        bindState(reactor)
        bindViews()
    }
}

extension IntroViewController {

    func bindAction(_ reactor: Reactor) {

        introView.signInWithKakakoButton.rx.tap
            .map { _ in Reactor.Action.didTapSignIn(.Kakao) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        introView.signInWithAppleButton.rx.tap
            .map { _ in Reactor.Action.didTapSignIn(.Apple) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        signInRelay
            .map { Reactor.Action.login(oAuthToken: $0.0, error: $0.1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func bindState(_ reactor: Reactor) {
        reactor.state.map { $0.signInType }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: login)
            .disposed(by: disposeBag)

        reactor.state.map { $0.enterInfoFlag }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: transferToEnterInfo)
            .disposed(by: disposeBag)

        reactor.state.map { $0.enterTabBarFlag }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: transferToTabBar)
            .disposed(by: disposeBag)
    }

    private func bindViews() {

        introView.nextButton.rx.tap
            .subscribe(onNext: {
                if self.currentPage == 2 {
                    // 프로필 설정 VC 로 넘어가기
                }
                else {
                    self.currentPage += 1
                    let indexPath = IndexPath(item: self.currentPage, section: 0)
                    self.introView.introCollectionView.isPagingEnabled = false
                    self.introView.introCollectionView.scrollToItem(
                        at: indexPath,
                        at: .centeredHorizontally,
                        animated: true)
                    self.introView.introCollectionView.isPagingEnabled = true
                }
            })
            .disposed(by: disposeBag)

        slideObservable
            .bind(to: (introView.introCollectionView.rx.items(
                cellIdentifier: IntroCollectionViewCell.className,
                cellType: IntroCollectionViewCell.self))
            ){ indexPath, content, cell in
                cell.slideImageView.image = content.image
                cell.slideDescriptionLabel.text = content.description
            }
            .disposed(by: disposeBag)

        introView.introCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

// state와 연결 될 Drive onNext 메서드
extension IntroViewController {
    private func login(_ signInType: SignInType?) {

        guard let signInType = signInType else {
            return
        }

        switch signInType {
        case .Apple:
            appleLoginManager.login()
        case .Kakao:
            kakaoLoginManager.login()
        }

    }

    private func transferToEnterInfo(_ isSuccess: Bool) {

        guard let signinType = reactor?.currentState.signInType,
              let oAuthToken = reactor?.currentState.oauthToken else { return }
        reactor?.action.onNext(.initial)
        
        let provider = ServiceProvider()

        let reactor = FirstProfileSettingReactor(
            provider: provider,
            signinType: signinType,
            oAuthToken: oAuthToken)

        let infoVC = FirstProfileSettingViewController(reactor)
        infoVC.modalPresentationStyle = .fullScreen
        infoVC.modalTransitionStyle = .crossDissolve
        self.view.window?.rootViewController = infoVC
    }

    private func transferToTabBar(_ isSuccess: Bool) {
        reactor?.action.onNext(.initial)
        let tabBarVC = TurnAroundTabBarViewController()
        changeRootViewController(to: tabBarVC)
    }
}

// 소셜 로그인 메서드
extension IntroViewController {

    private func configureAppleSignIn() {

        appleLoginManager.configure(in: self)

        appleLoginManager.onSuccess = { [weak self] identifyToken, accessToken in
            self?.signInRelay.accept((identifyToken, nil))
        }

        appleLoginManager.onFailure = { [weak self] error in
            self?.signInRelay.accept((nil, error))
        }
    }

    private func configureKakaoSignIn() {

        kakaoLoginManager.configure(appKey: "d22501ce396283c614192a90f04e3510")

        kakaoLoginManager.onSuccess = { [weak self] identifyToken, _ in
            self?.signInRelay.accept((identifyToken, nil))
        }

        kakaoLoginManager.onFailure = { [weak self] error in
            self?.signInRelay.accept((nil, error))
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
