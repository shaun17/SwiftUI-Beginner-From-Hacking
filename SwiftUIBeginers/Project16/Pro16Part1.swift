//
//  Pro15Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/1.
//

import SwiftUI

struct Pro16Part1: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selectedTab = "Two"

    @State private var selection = Set<String>()
    @State var editMode = EditMode.inactive

    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One") // 用于记录页签

            VStack {
                

                List(users, id: \.self, selection: $selection) { user in
                    Text(user)
                }
                EditButton()

            }
            .tabItem {
                Label("Two", systemImage: "circle")
            }
            .tag("Two")
            .environment(\.editMode, $editMode)
        }

        if !selection.isEmpty {
            Text("You selected \(selection.formatted())")
        }
    }
}

#Preview {
    Pro16Part1()
}
