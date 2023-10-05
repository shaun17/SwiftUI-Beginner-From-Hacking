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
                NavigationLink {
                    ChallengeTwo()
                } label: {
                    Label("Challenge Two", systemImage: "folder")
                }
                
                NavigationLink {
                    ChallengeThree()
                } label: {
                    Label("Challenge Three", systemImage: "folder")
                }
                
                NavigationLink {
                    Project1()
                } label: {
                    Label("project One", systemImage: "folder")
                }
                
                NavigationLink {
                    Project2()
                } label: {
                    Label("project Two", systemImage: "folder")
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
