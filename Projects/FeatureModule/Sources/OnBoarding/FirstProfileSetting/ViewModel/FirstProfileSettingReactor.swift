//
//  FirstProfileSettingReactor.swift
//  FeatureModuleTests
//
//  Created by 김지현 on 2022/11/02.
//  Copyright © 2022 turnaround.io. All rights reserved.
//

import Foundation
import ReactorKit
import ServiceModule

public class FirstProfileSettingReactor: ReactorKit.Reactor {

    private let provider: ServiceProviderType
    private let type: SignInType?
    private let token: String?

    init(provider: ServiceProviderType, signinType: SignInType, oAuthToken: String) {
        self.provider = provider
        self.type = signinType
        self.token = oAuthToken
    }

    public enum Action {
        case viewWillAppear
        case selectProfileImage(Int)
        case enterNickname(String)
        case didTapCheckNickname
        case nicknameStatusResult(Bool)
        case didTapSignup
    }

    public enum Mutation {
        case setCollectionViewCell([ProfileImageContent])
        case setSelectedProfileImage(String?)
        case setNickname(String?)
        case setIsCheckNickButtonHidden(Bool?)
        case setIsErrorLabelHidden(Bool?)
        case setSignupButtonValid(Bool?)
        case setUserId(Int?)
        case setIsNicknameValid(Bool?)
        case setIsSignupSuccess(Bool?)
        case setError(String?)
    }

    public struct State {
        var cellImages: [ProfileImageContent] = []
        var profileType: String?
        var nickname: String?
        var isCheckNickButtonHidden: Bool?
        var isErrorLabelHidden: Bool?
        var isSignupButtonValid: Bool?
        var userId: Int?
        var isNicknameValid: Bool?
        var isSignupSuccess: Bool?
        var error: String? = nil
    }

    public let initialState = State()

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return .just(Mutation.setCollectionViewCell(ProfileImageContent.data))

        case .selectProfileImage(let num):
            let profileType = stringImageNum(num)
            let nickname = currentState.nickname ?? ""
            return .concat([
                .just(Mutation.setSelectedProfileImage(profileType)),
                isSignupButtonValid(profileType, nickname)
            ])

        case .enterNickname(let nickname):
            let profileType = currentState.profileType ?? ""
            return .concat([
                .just(Mutation.setNickname(nickname)),
                isSignupButtonValid(profileType, nickname),
                isTextTyping()
            ])

        case .didTapCheckNickname:
            checkNickname()
            return .just(.setIsErrorLabelHidden(false))

        case let .nicknameStatusResult(isValid):
            return .concat([
                .just(.setIsNicknameValid(isValid)),
                .just(.setIsCheckNickButtonHidden(isValid))
            ])

        case .didTapSignup:
            signup()
            return .empty()
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {

        var newState = state

        switch mutation {
        case let .setCollectionViewCell(images):
            newState.cellImages = images

        case let .setSelectedProfileImage(profileType):
            newState.profileType = profileType

        case let .setNickname(nickname):
            newState.nickname = nickname

        case let .setIsCheckNickButtonHidden(flag):
            newState.isCheckNickButtonHidden = flag

        case let .setIsErrorLabelHidden(flag):
            newState.isErrorLabelHidden = flag

        case let .setSignupButtonValid(flag):
            newState.isSignupButtonValid = flag

        case let .setUserId(userId):
            newState.userId = userId

        case let .setIsNicknameValid(flag):
            newState.isNicknameValid = flag

        case let .setIsSignupSuccess(flag):
            newState.isSignupSuccess = flag

        case let .setError(err):
            newState.error = err
        }
        return newState
    }

    public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let serviceMutation = provider.authRepository.event.flatMap { event -> Observable<Mutation> in
            switch event {

            case .updateAccessToken(let accessToken):
                Keychain.shared.setAccessToken(accessToken: accessToken)
                return .just(.setIsSignupSuccess(true))

            case .updateRefreshToken(let refreshToken):
                Keychain.shared.setRefreshToken(refreshToken: refreshToken)
                return .empty()

            case .userId(let userId):
                return .just(Mutation.setUserId(userId))

            case .sendError(let errorModel):
                guard let errorModel = errorModel else {
                    return .empty()
                }

                return .just(.setError(errorModel.message))
            }
        }
        return Observable.merge(mutation, serviceMutation)
    }
}

extension FirstProfileSettingReactor {

    private func checkNickname() {

        guard let nickname = currentState.nickname else { return }

        let checkNicknameRequestDTO = UserDTO.Request.CheckNicnameRequestDTO(nickname: nickname)

        NetworkService.shared.userRepository.checkNickname(checkNicknameRequestDTO) { [weak self] res, err in

            guard let res = res else { return }

            if res.status == 200 {
                self?.action.onNext(.nicknameStatusResult(true))
            } else if res.status == 409 {
                print("무엇이 문제입니까")
                self?.action.onNext(.nicknameStatusResult(false))
            }
        }
    }

    private func signup() {

        guard let nickname = currentState.nickname,
              let profileType = currentState.profileType,
              let type = self.type,
              let token = self.token
        else { return }

        let signupRequestDTO = AuthDTO.Request.SignupRequestDTO(
            fcmToken: Keychain.shared.getFCMToken() ?? "",
            nickname: nickname,
            profileType: profileType,
            socialType: type.description,
            token: token)

        provider.authRepository.signup(signupRequestDTO)
    }

    private func stringImageNum(_ num: Int) -> String {

        var string = ""

        if num == 1 {
            string = "ONE"
        } else if num == 2 {
            string = "TWO"
        } else {
            string = "THREE"
        }

        return string
    }

    private func isSignupButtonValid(_ profileType: String, _ nickname: String) -> Observable<Mutation> {
        let validation = profileType != "" && nickname.count > 0
        return .just(Mutation.setSignupButtonValid(validation))
    }

    private func isTextTyping() -> Observable<Mutation> {
        if currentState.isErrorLabelHidden == false {
            return .concat([
                .just(Mutation.setIsErrorLabelHidden(true)),
                .just(Mutation.setIsCheckNickButtonHidden(false))
            ])
        }
        return .empty()
    }
}
