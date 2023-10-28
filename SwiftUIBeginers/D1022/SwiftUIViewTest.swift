//
//  SwiftUIViewTest.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/26.
//

import SwiftUI

struct SwiftUIViewTest: View {
    var body: some View {
        ZStack {
             Rectangle()
               .fill(Color.blue)

             Circle()
               .fill(Color.red)
               .overlay(
                 Text("Hello World")
                   .font(.largeTitle)
               )
           }
           .drawingGroup()
    }
}

#Preview {
    SwiftUIViewTest()
}
