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
    name: "TurnAround-iOS",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Project.FeatureModule
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist"),
    resourceSynthesizers: .assets()
)
