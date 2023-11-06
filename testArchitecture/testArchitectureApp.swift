//
//  testArchitectureApp.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import SwiftUI

@main
struct testArchitectureApp: App {
    @StateObject private var rootViewChanger = RootViewChanger.shared
    
    var body: some Scene {
        WindowGroup {
            if let rootViewType = rootViewChanger.rootViewType {
                switch rootViewType {
                case .loginView(let loginView): loginView
                case .mainView(let mainView): mainView
                }
            } else {
                // EntryPointViewのみ、Appから直接生成するとする
                EntryPointViewBuilder().build()
            }
        }
    }
}
