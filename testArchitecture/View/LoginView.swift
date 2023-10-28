//
//  LoginView.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewStateMachine: LoginViewStateMachine
    
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var buttonDisabled = true
    
    var body: some View {
        VStack {
            TextField("mail", text: self.$name)
            .onSubmit {
                self.loginViewStateMachine.action.send(.dismissKeyboard)
            }
            .onChange(of: self.name) { _, newValue in
                self.loginViewStateMachine.action.send(.inputName(name: newValue))
            }
            .background(Color.yellow)
            
            TextField("password", text: self.$password)
            .onSubmit {
                self.loginViewStateMachine.action.send(.dismissKeyboard)
            }
            .onChange(of: self.password) { _, newValue in
                self.loginViewStateMachine.action.send(.inputPassword(password: newValue))
            }
            .background(Color.yellow)
            
            Button("Login") {
                self.loginViewStateMachine.action.send(.tapLoginButton)
            }
            .background(self.buttonDisabled ? Color.gray : Color.blue)
            .disabled(self.buttonDisabled)
        }
        .padding()
        .onChange(of: self.loginViewStateMachine.state) { _, newValue in
            switch newValue {
            case .None:
                self.buttonDisabled = true
            case .Inputting:
                self.buttonDisabled = true
            case .Prepared:
                self.buttonDisabled = false
            case .UnreasonableValue:
                self.buttonDisabled = true
            case .Loading: 
                self.buttonDisabled = true
            case .Retryable:
                self.buttonDisabled = false
            case .LoginCompleted:
                self.buttonDisabled = false
            }
        }
    }
}

#Preview {
    LoginView(loginViewStateMachine: LoginViewStateMachine(nameValueChecker: NameValueChecker(), passwordValueChecker: PasswordValueChecker(), postLoginAPICommander: PostLoginAPICommander(client: APIClient()), loggedInUserDefaultsCommander: LoggedInUserDefaultsCommander(client: UserDefaultsClient())))
}
