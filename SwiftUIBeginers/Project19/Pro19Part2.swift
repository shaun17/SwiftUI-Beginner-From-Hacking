//
//  Pro19Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/23.
//

import SwiftUI

struct Pro19Part2: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct Pro19Part2_Second: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
//        let a = print(horizontalSizeClass == .compact)
        if horizontalSizeClass == .compact {
            VStack {
                Pro19Part2()
            }
        } else {
            HStack {
                Pro19Part2()
            }
        }

        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)
            Circle()
                .frame(width: 200, height: 200)
        }
        
    }
}

#Preview {
    Pro19Part2_Second()
}
