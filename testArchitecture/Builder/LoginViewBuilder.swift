//
//  LoginViewBuilder.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

struct LoginViewBuilder {
    @MainActor func build() -> LoginView {
        let nameValueChecker = NameValueChecker()
        let passwordValueChecker = PasswordValueChecker()
        let postLoginAPICommander = PostLoginAPICommander(client: APIClient())
        let loggedInUserDefaultsCommander = LoggedInUserDefaultsCommander(client: UserDefaultsClient())
        let stateMachine = LoginViewStateMachine(nameValueChecker: nameValueChecker,
                                                 passwordValueChecker: passwordValueChecker,
                                                 postLoginAPICommander: postLoginAPICommander,
                                                 loggedInUserDefaultsCommander: loggedInUserDefaultsCommander)
        return LoginView(loginViewStateMachine: stateMachine)
    }
}
