//
//  BottomButtonTab.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class BottomButtonTab: UIView {
    
    public var cornerRadius: CGFloat = 14.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
    public var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    public var borderColor: UIColor = FeatureModuleAsset.ColorAsset.gray10.color {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    public var filledColor: UIColor = FeatureModuleAsset.ColorAsset.gray1.color {
        didSet {
            self.backgroundColor = filledColor
        }
    }
    
    public var leftButton: UIButton = LongButton() {
        didSet {
            leftButton.layer.masksToBounds = true
            leftButton.layer.cornerRadius = 10
            self.subviews.forEach { $0.removeFromSuperview() }
            render()
        }
    }
    
    public var leftButtonFilledColor: UIColor = FeatureModuleAsset.ColorAsset.gray10.color {
        didSet {
            leftButton.backgroundColor = leftButtonFilledColor
        }
    }
    
    public var rightButton: UIButton = StrokeButton() {
        didSet {
            rightButton.layer.masksToBounds = true
            rightButton.layer.cornerRadius = 10
            self.subviews.forEach { $0.removeFromSuperview() }
            render()
        }
    }
    
    public var rightButtonFilledColor: UIColor = UIColor.white {
        didSet {
            rightButton.backgroundColor = rightButtonFilledColor
        }
    }
    
    public var rightButtonBorderColor: UIColor = FeatureModuleAsset.ColorAsset.gray10.color {
        didSet {
            rightButton.layer.borderColor = rightButtonBorderColor.cgColor
        }
    }
    
    public var rightButtonBorderWidth: CGFloat = 1.0 {
        didSet {
            rightButton.layer.borderWidth = rightButtonBorderWidth
        }
    }
    
    // MARK: - intializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        render()
        
        defer {
            self.cornerRadius = 14.0
            self.borderWidth = 1.0
            self.borderColor = FeatureModuleAsset.ColorAsset.gray10.color
            self.filledColor = FeatureModuleAsset.ColorAsset.gray1.color
            self.leftButton = LongButton()
            self.leftButtonFilledColor = FeatureModuleAsset.ColorAsset.gray10.color
            self.rightButton = StrokeButton()
            self.rightButtonFilledColor = UIColor.white
            self.rightButtonBorderColor = FeatureModuleAsset.ColorAsset.gray10.color
            self.rightButtonBorderWidth = 1.0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        let stack = UIStackView(arrangedSubviews: [leftButton, rightButton])
        addSubview(stack)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
            $0.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}
