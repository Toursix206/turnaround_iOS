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
    name: "ServiceModule",
    product: .staticFramework,
    dependencies: [
//        .project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/ThirdPartyLib"))
        .Project.ThirdPartyLib
    ],
    resourceSynthesizers: .assets()
)
