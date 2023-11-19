//
//  ContentView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/25.
//

import SwiftUI
import CoreData
struct ContentView: View {
    @StateObject private var dataController = DataController()
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
                Spacer()
                NavigationLink {
                    
                    CoreData_Project11()
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                } label: {
                    Label("test", systemImage: "folder")
                }
                NavigationLink {
                    
                    SpaceListView_Project12()
                        .environment(\.managedObjectContext,dataController.container2.viewContext)
                } label: {
                    Label("Space", systemImage: "folder")
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
