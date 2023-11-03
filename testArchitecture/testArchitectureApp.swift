//
//  testArchitectureApp.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import SwiftUI

@main
struct testArchitectureApp: App {
    @StateObject private var rootViewChangeNotifier = RootViewChangeNotifier.shared
    
    var body: some Scene {
        WindowGroup {
            switch rootViewChangeNotifier.rootViewType {
            case .entryPointView:
                EnryPointViewBuilder().build()
            case .loginView:
                LoginViewBuilder().build()
            case .mainView:
                MainView()
            }
        }
    }
}
