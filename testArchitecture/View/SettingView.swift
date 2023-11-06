//
//  SettingView.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/05.
//

import SwiftUI

struct SettingView: View {
    @StateObject var settingViewStateMachine: SettingViewStateMachine
    @StateObject var settingViewRouter: SettingViewRouter
    
    var body: some View {
        VStack {
            Text("Setting")
            
            Button("show alert") {
                self.settingViewStateMachine.action.send(.tapAlertButton)
            }
        }
        .alert(isPresented: self.$settingViewRouter.isFugaAlertPresented) {
            self.settingViewRouter.presentedFugaAlert
        }
        .padding()
    }
}
