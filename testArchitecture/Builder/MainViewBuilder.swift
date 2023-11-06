//
//  MainViewBuilder.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/04.
//

struct MainViewBuilder {
    @MainActor func build() -> MainView {
        let mainViewRouter = MainViewRouter()
        let rootViewChanger = RootViewChanger.shared
        let mainViewStateMachine = MainViewStateMachine(rootViewChanger: rootViewChanger,
                                                        mainViewRouter: mainViewRouter)
        return MainView(mainViewStateMachine: mainViewStateMachine, mainViewRouter: mainViewRouter)
    }
}
