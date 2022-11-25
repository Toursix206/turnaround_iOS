//
//  ToolTipView.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import Then
import RxSwift
import RxCocoa

public class ToolTipView: UIView {
    
    public var filledColor: UIColor = FeatureModuleAsset.ColorAsset.point.color {
        didSet {
            self.backgroundColor = filledColor
        }
    }
    
    public var exitButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(FeatureModuleAsset.ImageAsset.close.image, for: .normal)
    }
    
    public var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    private let textLabel = UILabel().then {
        $0.font = UIFont.customFont(.captionSemiBold)
        $0.textColor = UIColor.white
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: - initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
        
        exitButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.isHidden = true
            }).disposed(by: disposeBag)
        
        defer {
            self.filledColor = FeatureModuleAsset.ColorAsset.point.color
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        drawBottomTipView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        
        let stack = UIStackView(arrangedSubviews: [textLabel, exitButton])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        self.addSubview(stack)
        
        snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(stack.snp.width).offset(19)
        }
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        sizeToFit()
    }
    
    private func drawBottomTipView() {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: (self.bounds.maxX / 2) - 4.5, y: self.bounds.maxY))
        path.addLine(to: CGPoint(x: (self.bounds.maxX / 2) + 4.5, y: self.bounds.maxY))
        path.addLine(to: CGPoint(x: self.bounds.maxX / 2, y: self.bounds.maxY + 8))
        path.close()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = FeatureModuleAsset.ColorAsset.point.color.cgColor
        
        self.layer.insertSublayer(shape, at: 0)
        self.layer.masksToBounds = false
    }
}

extension UIButton {
    // 반드시 버튼의 부모 뷰에서 addSubView 한 이후에 호출할 것.
    func setToolTipView(_ toolTipText: String) {
        let toolTipView = ToolTipView()
        toolTipView.text = toolTipText
        self.superview?.addSubview(toolTipView)
        toolTipView.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.top).offset(-18)
            $0.centerX.equalTo(self.snp.centerX)
        }
    }
}
