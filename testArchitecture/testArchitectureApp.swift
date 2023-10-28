//
//  testArchitectureApp.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import SwiftUI

@main
struct testArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            EntryPointView(loginViewBuilder: LoginViewBuilder())
        }
    }
}
