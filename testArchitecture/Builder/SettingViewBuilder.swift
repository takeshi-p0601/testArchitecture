//
//  SettingViewBuilder.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/06.
//

struct SettingViewBuilder {
    @MainActor func build() -> SettingView {
        let settingViewRouter = SettingViewRouter()
        let settingViewStateMachine = SettingViewStateMachine(settingViewRouter: settingViewRouter)
        return SettingView(settingViewStateMachine: settingViewStateMachine, settingViewRouter: settingViewRouter)
    }
}
