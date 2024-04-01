//
//  Pro15Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/1.
//

import SwiftUI

struct Pro16Part1: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selectedTab = "One"

    @State private var selection = Set<String>()

    var body: some View {
        TabView(selection: $selectedTab){
            
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")

            VStack {
                EditButton()

                List(users, id: \.self, selection: $selection) { user in
                    Text(user)
                }
            }
            .tabItem {
                Label("Two", systemImage: "circle")
            }
            .tag("Two")
        }

        if !selection.isEmpty {
            Text("You selected \(selection.formatted())")
        }
    }
}

#Preview {
    Pro16Part1()
}
