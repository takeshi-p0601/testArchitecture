//
//  SettingViewRouter.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/06.
//

import Foundation
import SwiftUI

@MainActor
protocol SettingViewRouterable {
    // fuga alert
    var isFugaAlertPresented: Bool { get }
    var presentedFugaAlert: Alert { get }
    func showFugaAlert()
}

class SettingViewRouter: ObservableObject, SettingViewRouterable {
    @Published var isFugaAlertPresented: Bool = false
    var presentedFugaAlert: Alert { self._presentedFugaAlert }
    private var _presentedFugaAlert: Alert = .init(title: Text(""))
            
    func showFugaAlert() {
        self._presentedFugaAlert = Alert(title: Text("fuga fuga alert"),
                                    dismissButton: Alert.Button.default(Text("OK"), action: {
        }))
        self.isFugaAlertPresented = true
    }
    
}
