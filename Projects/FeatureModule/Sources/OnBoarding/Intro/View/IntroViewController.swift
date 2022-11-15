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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
    }
    
    public func bind(reactor: IntroReactor) {
        
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

extension IntroViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
