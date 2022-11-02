//
//  NSObject+Extension.swift
//  FeatureModule
//
//  Created by 강민성 on 2022/11/01.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
}
