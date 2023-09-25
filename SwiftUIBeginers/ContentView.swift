//
//  ContentView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/25.
//

import SwiftUI

struct ContentView: View {
    @State var isNavPush = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    ChallengeOne()
                } label: {
                    Label("Challenge One", systemImage: "folder")
                }
    
            }
            .navigationTitle("Challenges")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
