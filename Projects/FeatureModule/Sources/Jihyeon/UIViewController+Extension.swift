//
//  UIViewController+Extension.swift
//  FeatureModule
//
//  Created by 김지현 on 2022/10/24.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
