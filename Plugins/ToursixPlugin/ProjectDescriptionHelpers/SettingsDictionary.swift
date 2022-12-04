//
//  SettingsDictionary.swift
//  MyPlugin
//
//  Created by 강민성 on 2022/11/29.
//

import ProjectDescription

public extension SettingsDictionary {
    func setFirebaseDependency() -> SettingsDictionary {
        merging(["OTHER_LDFLAGS": ["-ObjC", "$(OTHER_LDFLAGS)"]])
    }
}
