//
//  Pro19Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/24.
//

import SwiftUI

struct Pro19Part3: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { $0.localizedStandardContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Looking for Searching")
            .navigationTitle("Searching")
        }
    }
}

#Preview {
    Pro19Part3()
}
