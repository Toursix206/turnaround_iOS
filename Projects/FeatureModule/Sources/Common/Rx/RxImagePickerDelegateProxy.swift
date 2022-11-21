//
//  RxImagePickerDelegateProxy.swift
//  FeatureModule
//
//  Created by 김인환 on 2022/11/21.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

#if os(iOS)

import RxSwift
import RxCocoa
import UIKit

open class RxImagePickerDelegateProxy
    : RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {

    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }

}

#endif
