//
//  ContentView.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import SwiftUI

struct EntryPointView: View {
    @StateObject var entryPointViewStateMachine: EntryPointViewStateMachine
    
    var body: some View {
        EmptyView()
            .onAppear {
                self.entryPointViewStateMachine.action.send(.onAppear)
            }
    }
}

//#Preview {
//    EntryPointView()
//}
