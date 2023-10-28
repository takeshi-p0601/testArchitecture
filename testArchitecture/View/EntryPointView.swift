//
//  ContentView.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import SwiftUI

struct EntryPointView: View {
    let loginViewBuilder: LoginViewBuilder
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("LoginへGo") {
                isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented, content: {
                loginViewBuilder.build()
            })
//            .sheet(isPresented: $isPresented, content: {
//                loginViewBuilder.build()
//            })
        }
        .padding()
    }
}

#Preview {
    EntryPointView(loginViewBuilder: LoginViewBuilder())
}
