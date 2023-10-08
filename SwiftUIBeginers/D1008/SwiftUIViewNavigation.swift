//
//  SwiftUIViewNavigation.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/8.
//

import SwiftUI

struct SwiftUIViewNavigation: View {
    var body: some View {
        NavigationView(content: {
            List(0..<100){row in
                NavigationLink(destination: Text("Destination \(row)")) {
                    Text("Navigate \(row)")
                }
            }
            .navigationTitle("Navigation")
           
        })
    }
}

#Preview {
    SwiftUIViewNavigation()
}
