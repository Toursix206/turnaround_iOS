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
    name: "FeatureModule",
    product: .staticFramework,
    dependencies: [
//        .project(target: "ServiceModule", path: .relativeToRoot("Projects/ServiceModule"))
        .Project.ServiceModule
    ],
    resources: ["Resources/**"],
    resourceSynthesizers: .assets()
)
