//
//  HogeViewBuilder.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/06.
//

import SwiftUI

struct HogeViewBuilder {
    @MainActor func build() -> HogeView {
        return HogeView()
    }
}
