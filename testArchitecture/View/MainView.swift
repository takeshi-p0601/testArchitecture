//
//  LoggedInView.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/31.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainViewStateMachine: MainViewStateMachine
    @StateObject var mainViewRouter: MainViewRouter
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Main")
                
                Button {
                    self.mainViewStateMachine.action.send(.tapMeButton)
                } label: {
                    Text("tap me")
                }
                
                Button {
                    self.mainViewStateMachine.action.send(.tapHogeButton)
                } label: {
                    Text("tap hoge")
                }

            }
            .padding()
            .navigationDestination(isPresented: self.$mainViewRouter.isSettingViewActivated, destination: {
                self.mainViewRouter.activatedSettingView
            })
        }
        .fullScreenCover(isPresented: self.$mainViewRouter.isHogeViewActivated) {
            self.mainViewRouter.activatedHogeView
        }
    }
}
