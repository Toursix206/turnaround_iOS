//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 2022/10/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

import MyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxRelay,
        .SPM.Alamofire,
        .SPM.Moya,
        .SPM.ReactorKit,
        .SPM.Then,
        .SPM.Lottie,
        .SPM.Snapkit,
        .SPM.RxGesture,
        .SPM.SwiftKeychainWrapper,
        .SPM.DiffableDataSources,
        .SPM.RxDataSources,
        .SPM.RxAlamofire
    ],
    resourceSynthesizers: .assets()
)
