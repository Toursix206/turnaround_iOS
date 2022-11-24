//
//  StrokeButton.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

public class StrokeButton: UIButton {
    
    public var cornerRadius: CGFloat = 14.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
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
    
    public var filledColor: UIColor = UIColor.white {
        didSet {
            self.backgroundColor = filledColor
        }
    }
    
    public var titleText: String = "" {
        didSet {
            self.setAttributedTitle(NSAttributedString(string: titleText,
                                                       attributes: [.font: UIFont.customFont(.body1SemiBold)]),
                                    for: .normal)
        }
    }
    
    public var titleColor: UIColor = FeatureModuleAsset.ColorAsset.gray10.color {
        didSet {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    // MARK: - initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        defer {
            self.cornerRadius = 14.0
            self.borderColor = FeatureModuleAsset.ColorAsset.gray10.color
            self.borderWidth = 1.0
            self.filledColor = UIColor.white
            self.titleText = ""
            self.titleColor = FeatureModuleAsset.ColorAsset.gray10.color
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
