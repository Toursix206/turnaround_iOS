//
//  IntroModel.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/10/30.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import UIKit

struct IntroModel {
    var description: String
    var image: FeatureModuleImages.Image
    
    static let firstPage = IntroModel(description: "지금 당장 내방을 닮은\n 방타버스로 입주하세요", image: FeatureModuleAsset.ImageAsset.onBoarding1.image)
    static let secondPage = IntroModel(description: "집에서하는 활동을 인증하고\n 방타버스를 성장시켜요", image: FeatureModuleAsset.ImageAsset.onBoarding2.image)
    static let thirdPage = IntroModel(description: "집안일부터 청소까지\n 계획적이고 편하게 따라해요", image: FeatureModuleAsset.ImageAsset.onBoarding3.image)
    
    static let slideContents = [firstPage, secondPage, thirdPage]
}

