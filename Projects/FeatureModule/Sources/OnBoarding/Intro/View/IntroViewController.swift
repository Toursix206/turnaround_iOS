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

public class IntroViewController: UIViewController{
    
    var introCollectionView: UICollectionView!
    
    var disposeBag = DisposeBag()
    
    var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        return pageControl
    }()
    
    var introView = IntroView()
    
    var slideObservable = Observable.of(IntroModel.slideContents)
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == 2 {
                introView.signInWithAppleButtonTemp.isHidden = false
                introView.signInWithKakakoButton.isHidden = false
                
            }
            else {
                introView.signInWithAppleButtonTemp.isHidden = true
                introView.signInWithKakakoButton.isHidden = true
            }
        }
    }
    
    public override func loadView() {
        super.loadView()
        view = introView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
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
