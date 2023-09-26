//
//  SwiftUIViewButton.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/26.
//

import SwiftUI

struct SwiftUIViewButton: View {
    var body: some View {
        VStack {
            Button("Button 1") {
                print("Button 1 Click")
            }
            Button("Button 2") {
                print("Button 2 Click")
            }.buttonStyle(.bordered)

            Button("Button 3") {
                print("Button 3 Click")
            }
            .foregroundColor(.brown)
            .buttonStyle(.borderedProminent)
            .tint(.mint)

            Button {
                print("Button 4 Click")
            } label: {
                Label("Button 4", systemImage: "cloud")
            }
            .buttonStyle(.borderedProminent)
            .tint(.brown)
        }
    }
}

struct SwiftUIViewButton_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewButton()
    }
}
