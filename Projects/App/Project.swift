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
    name: "TurnAroundiOS",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Project.FeatureModule,
        .SPM.FirebaseCrashlytics,
        .SPM.FirebaseMessaging,
        .SPM.FirebaseAnalytics
    ],
    resources: ["Resources/**"],
    entitlements: Path("TurnAroundiOS.entitlements"),
    infoPlist: .file(path: "Support/Info.plist"),
    resourceSynthesizers: .assets()
)
