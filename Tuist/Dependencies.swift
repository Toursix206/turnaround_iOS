//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 2022/10/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .upToNextMajor(from: "6.5.0")
        ),
        .remote(
            url: "https://github.com/Moya/Moya.git",
            requirement: .upToNextMajor(from: "15.0.0")
        ),
        .remote(
            url: "https://github.com/ReactorKit/ReactorKit.git",
            requirement: .upToNextMajor(from: "3.0.0")
        ),
        .remote(
            url: "https://github.com/airbnb/lottie-ios.git",
            requirement: .upToNextMajor(from: "3.5.0")
        ),
        .remote(
            url: "https://github.com/devxoul/Then.git",
            requirement: .upToNextMajor(from: "3.0.0.")
        ),
        .remote(
            url: "https://github.com/SnapKit/SnapKit.git",
            requirement: .upToNextMajor(from: "5.0.1")
        ),
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxGesture.git",
            requirement: .upToNextMajor(from: "4.0.0")
        ),
        .remote(
            url: "https://github.com/jrendel/SwiftKeychainWrapper",
            requirement: .revision("185a3165346a03767101c4f62e9a545a0fe0530f")
        ),
        .remote(
            url: "https://github.com/ra1028/DiffableDataSources.git",
            requirement: .upToNextMajor(from: "0.5.0")
        ),
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxDataSources.git",
            requirement: .upToNextMajor(from: "5.0.0")
        ),
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxAlamofire.git",
            requirement: .upToNextMajor(from: "6.1.2")
        ),
        .remote(
            url: "https://github.com/kakao/kakao-ios-sdk",
            requirement: .branch("master")
        ),
        .remote(
            url: "https://github.com/kakao/kakao-ios-sdk-rx",
            requirement: .branch("master")
        ),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            .upToNextMajor(from: "8.10.0")
        ),
        .remote(
            url: "https://github.com/onevcat/Kingfisher.git",
            requirement: .upToNextMajor(from: "7.0")
        )
    ],
    platforms: [.iOS]
)

