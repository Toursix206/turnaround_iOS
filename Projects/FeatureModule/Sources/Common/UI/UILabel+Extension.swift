//
//  UILabel+Extension.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/20.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit
import SnapKit

extension UILabel {
    
    static func makeFreeTag() -> UILabel {
        
        let label = UILabel()
        
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 0.8
        label.layer.borderColor = FeatureModuleAsset.ColorAsset.gray9.color.cgColor
        
        label.font = UIFont.customFont(.body2Bold)
        label.text = "FREE"
        label.textColor = FeatureModuleAsset.ColorAsset.gray9.color
        label.textAlignment = .center
        
        label.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(20)
        }
        
        return label
    }
    
    static func makeKitTag() -> UILabel {
        
        let label = UILabel()
        
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 0.8
        label.layer.borderColor = FeatureModuleAsset.ColorAsset.point.color.cgColor
        
        label.font = UIFont.customFont(.body2Bold)
        label.text = "KIT"
        label.textColor = FeatureModuleAsset.ColorAsset.point.color
        label.textAlignment = .center
        
        label.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(20)
        }
        
        return label
    }
    
    static func makeSuccessTag() -> UILabel {
        
        let label = UILabel()
        
        label.backgroundColor = FeatureModuleAsset.ColorAsset.gray10.color
        label.layer.cornerRadius = 4
        
        label.font = UIFont.customFont(.captionSemiBold)
        label.text = "성공"
        label.textColor = .white
        label.textAlignment = .center
        
        label.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(20)
        }
        
        return label
    }
    
    static func makeFailTag() -> UILabel {
        
        let label = UILabel()
        
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 1
        label.layer.borderColor = FeatureModuleAsset.ColorAsset.alert.color.cgColor
        
        label.font = UIFont.customFont(.captionSemiBold)
        label.text = "실패"
        label.textColor = FeatureModuleAsset.ColorAsset.alert.color
        label.textAlignment = .center
        
        label.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(20.13)
        }
        
        return label
    }
    
    static func makeDarkFilledTag(_ text: String) -> UILabel {
        
        let label = UILabel()
        
        label.backgroundColor = FeatureModuleAsset.ColorAsset.gray2.color
        label.layer.cornerRadius = 4
        
        label.font = UIFont.customFont(.captionSemiBold)
        label.text = text
        label.textColor = FeatureModuleAsset.ColorAsset.gray9.color
        label.textAlignment = .center
        
        switch text.count >= 4 {
        case true :
            label.snp.makeConstraints { make in
                make.width.equalTo(58)
                make.height.equalTo(20)
            }
        case false :
            label.snp.makeConstraints { make in
                make.width.equalTo(48)
                make.height.equalTo(20)
            }
        }
        
        return label
    }
    
    static func makePurpleFilledTag(_ text: String) -> UILabel {
        
        let label = UILabel()
        
        label.backgroundColor = UIColor(red: 0.914, green: 0.871, blue: 1, alpha: 1)
        label.layer.cornerRadius = 4
        
        label.font = UIFont.customFont(.captionSemiBold)
        label.text = text
        label.textColor = FeatureModuleAsset.ColorAsset.point.color
        label.textAlignment = .center
        
        switch text.count >= 4 {
        case true :
            label.snp.makeConstraints { make in
                make.width.equalTo(58)
                make.height.equalTo(20)
            }
        case false :
            label.snp.makeConstraints { make in
                make.width.equalTo(48)
                make.height.equalTo(20)
            }
        }
        
        return label
    }
    
    static func makeToastMessage(_ text: String, _ textColor: UIColor, _ width: ConstraintRelatableTarget, _ height: ConstraintRelatableTarget) -> UILabel {
        
        let label = UILabel()
        
        let shadow = UIView()
        
        let shadowPath = UIBezierPath(roundedRect: shadow.bounds, cornerRadius: 32)
        
        let layer = CALayer()
        
        label.addSubview(shadow)
        
        label.backgroundColor = FeatureModuleAsset.ColorAsset.point.color
        label.layer.cornerRadius = 32
        
        label.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        shadow.frame = label.frame
        
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.24).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 18
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.bounds = shadow.bounds
        layer.position = shadow.center
        
        shadow.layer.addSublayer(layer)
        
        shadow.frame = label.frame
        shadow.clipsToBounds = false
        
        label.font = UIFont.customFont(.body2SemiBold)
        label.text = text
        label.textColor = textColor
        label.textAlignment = .center
        
        return label
    }
    
}
