//
//  ProPArt1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/23.
//

import SwiftUI

extension ProPart1 {
    struct User: Identifiable {
        var id = "Taylor Swift"
    }
}

struct ProPart1: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false

    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all), sidebar: {
            NavigationLink(value: "Primary") {
                Text("New View")
                    .navigationTitle("Primary View")
            }
        }, detail: {
            Text("Content")
                .navigationTitle("Content View")
            Button("Tap Me") {
                selectedUser = User()
                isShowingUser = true
            }
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) {}
//            }
            .sheet(item: $selectedUser, content: { user in
                Text(user.id)
                    .presentationDetents([.medium, .large])
            })
        })
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    ProPart1()
}
