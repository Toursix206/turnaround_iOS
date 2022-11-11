//
//  UIFont+Extension.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/11.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import UIKit

enum Fonts {
    case H1Bold
    case H1SemiBold
    case H2Bold
    case H2SemiBold
    case subHeadLineBold
    case subHeadLineSemiBold
    case body1Regular
    case body1SemiBold
    case body2Regular
    case body2SemiBold
    case captionRegular
    case captionSemiBold
}

extension UIFont {
    
    static func customFont(_ name: Fonts) -> UIFont {
        
        switch name {
            
        case .H1Bold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.bold, size: 22)!
        case .H1SemiBold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 22)!
        case .H2Bold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.bold, size: 20)!
        case .H2SemiBold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 20)!
        case .subHeadLineBold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.bold, size: 18)!
        case .subHeadLineSemiBold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 18)!
        case .body1Regular:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.regular, size: 16)!
        case .body1SemiBold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 16)!
        case .body2Regular:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.regular, size: 14)!
        case .body2SemiBold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 14)!
        case .captionRegular:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.regular, size: 12)!
        case .captionSemiBold:
            return UIFont(font: FeatureModuleFontFamily.Pretendard.semiBold, size: 12)!
        }
    }
}
