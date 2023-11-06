//
//  MainViewRouter.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/05.
//

import Foundation
import SwiftUI

@MainActor
protocol MainViewRouterable {
    // settingView
    var isSettingViewActivated: Bool { get }
    var activatedSettingView: SettingView? { get }
    func activateSettingView()
    // hogeView
    var isHogeViewActivated: Bool { get }
    var activatedHogeView: HogeView? { get }
    func activateHogeView()
}

class MainViewRouter: ObservableObject, MainViewRouterable {
    @Published var isSettingViewActivated: Bool = false
    var activatedSettingView: SettingView? { self._activatedSettingView }
    private var _activatedSettingView: SettingView? = nil
    
    @Published var isHogeViewActivated: Bool = false
    var activatedHogeView: HogeView? { self._activatedHogeView }
    private var _activatedHogeView: HogeView? = nil
    
    func activateSettingView() {
        self._activatedSettingView = SettingViewBuilder().build()
        self.isSettingViewActivated = true
    }
    
    func activateHogeView() {
        self._activatedHogeView = HogeViewBuilder().build()
        self.isHogeViewActivated = true
    }
}
