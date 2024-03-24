//
//  Pro10Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/21.
//

import SwiftUI

struct Pro10Part2: View {
    @State private var count = 0
    var body: some View {
        Button("tap me \(count)"){
            count += 1
        }
//        .sensoryFeedback(.increase, trigger: count)
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: count)
    }
}

#Preview {
    Pro10Part2()
}
