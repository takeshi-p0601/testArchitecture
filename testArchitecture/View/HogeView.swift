//
//  HogeView.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/05.
//

import SwiftUI

struct HogeView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Hoge")
            
            Button("dismiss") {
                self.dismiss()
            }
        }
        .padding()
    }
}
