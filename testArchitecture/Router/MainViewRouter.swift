//
//  MainViewRouter.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/05.
//

import Foundation

@MainActor
protocol MainViewRouterable {
    // settingView
    var settingView: (activated: Bool, viewItself: SettingView?) { get }
    func activateSettingView()
    // hogeView
    var hogeView: (activated: Bool, viewItself: HogeView?) { get }
    func activateHogeView()
}

class MainViewRouter: ObservableObject, MainViewRouterable {
    var settingView: (activated: Bool, viewItself: SettingView?) { self._settingView }
    @Published private var _settingView: (activated: Bool, viewItself: SettingView?) = (activated: false, viewItself: nil)
    
    var hogeView: (activated: Bool, viewItself: HogeView?) { self._hogeView }
    @Published private var _hogeView: (activated: Bool, viewItself: HogeView?) = (activated: false, viewItself: nil)
    
    func activateSettingView() {
        self._settingView = (activated: true, viewItself: SettingView())
    }
    
    func activateHogeView() {
        self._hogeView = (activated: true, viewItself: HogeView())
    }
}
