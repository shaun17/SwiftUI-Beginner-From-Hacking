//
//  SwiftUIViewGridView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/8.
//

import SwiftUI

struct SwiftUIViewGridView: View {
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 120))], content: {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            })
        }
    }
}

#Preview {
    SwiftUIViewGridView()
}
