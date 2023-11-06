//
//  MainViewRouter.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/05.
//

import Foundation

protocol MainViewRouterable {
    // settingView
    var settingView: (activated: Bool, itself: SettingView?) { get }
    func activateSettingView()
    // hogeView
    var hogeView: (activated: Bool, itself: HogeView?) { get }
    func activateHogeView()
}

class MainViewRouter: ObservableObject, MainViewRouterable {
    var settingView: (activated: Bool, itself: SettingView?) { self._settingView }
    @Published private var _settingView: (activated: Bool, itself: SettingView?) = (activated: false, itself: nil)
    
    var hogeView: (activated: Bool, itself: HogeView?) { self._hogeView }
    @Published private var _hogeView: (activated: Bool, itself: HogeView?) = (activated: false, itself: nil)
    
    func activateSettingView() {
        // TODO: BuilderからViewを作成して入れ込む
        self._settingView = (activated: true, itself: SettingView())
    }
    
    func activateHogeView() {
        // TODO: BuilderからViewを作成して入れ込む
        self._hogeView = (activated: true, itself: HogeView())
    }
}
