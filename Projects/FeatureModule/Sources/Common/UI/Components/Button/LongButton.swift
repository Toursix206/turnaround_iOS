//
//  BottomButton.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/23.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

public class LongButton: UIButton {
    
    public var cornerRadius: CGFloat = 14.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    public var fillColor: UIColor = FeatureModuleAsset.ColorAsset.gray10.color {
        didSet {
            if isEnabled {
                self.backgroundColor = fillColor
            } else {
                self.backgroundColor = disabledColor
            }
        }
    }
    
    public var disabledColor: UIColor = FeatureModuleAsset.ColorAsset.gray4.color {
        didSet {
            if isEnabled {
                self.backgroundColor = fillColor
            } else {
                self.backgroundColor = disabledColor
            }
        }
    }
    
    public var titleColor: UIColor = UIColor.white {
        didSet {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    
    public var disabledTitleColor: UIColor = FeatureModuleAsset.ColorAsset.gray6.color {
        didSet {
            self.setTitleColor(disabledTitleColor, for: .disabled)
        }
    }
    
    public var titleText: String = "" {
        didSet {
            self.setAttributedTitle(NSAttributedString(string: titleText, attributes: [.font: UIFont.customFont(.body1SemiBold)]), for: .normal)
            self.setAttributedTitle(NSAttributedString(string: titleText, attributes: [.font: UIFont.customFont(.body1SemiBold)]), for: .disabled)
        }
    }
    
    // MARK: - initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        defer {
            cornerRadius = 14.0
            fillColor = FeatureModuleAsset.ColorAsset.gray10.color
            disabledColor = FeatureModuleAsset.ColorAsset.gray4.color
            titleColor = UIColor.white
            disabledTitleColor = FeatureModuleAsset.ColorAsset.gray6.color
            titleText = ""
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
