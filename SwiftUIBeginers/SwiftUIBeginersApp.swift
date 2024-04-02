//
//  SwiftUIBeginersApp.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftUIBeginersApp: App {
    var body: some Scene {
        WindowGroup {
            VStack {
                ContentView()
            }
        }
        .modelContainer(for: Prospect.self)
        .modelContainer(for: StudentPro11.self)
        .modelContainer(for: BookPro11.self)
    }
}


