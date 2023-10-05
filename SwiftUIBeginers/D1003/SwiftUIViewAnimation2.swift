//
//  SwiftUIViewAnimation2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/3.
//

import SwiftUI

struct SwiftUIViewAnimation2: View {
    @State private var enabled = false
    var body: some View {
        Button("Clike me") {
            enabled.toggle()
        }
        .frame(width: 100, height: 100)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)

        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 5, damping: 1), value: enabled)

    }
}

#Preview {
    SwiftUIViewAnimation2()
}
