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
                Spacer()
                
                NavigationLink {
//                    Pro16Part4()
//                        .modelContainer(for: Prospect.self)
                    Pro17Part5View()

                } label: {
                    Label("Project demo", systemImage: "folder")
                    
                }
                Spacer()
                NavigationLink {
                    Challenge1()
                } label: {
                    Label("Challenge1", systemImage: "folder")
                }
                NavigationLink {
                    Challenge2()
                } label: {
                    Label("Challenge Two", systemImage: "folder")
                }
                
                NavigationLink {
                    Challenge3()
                } label: {
                    Label("Challenge Three", systemImage: "folder")
                }
                
                NavigationLink {
                    Challeng4_6()
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
