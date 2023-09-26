//
//  SwiftUIView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.blue
                Color.yellow
            }
            
            Text("aaaa")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
