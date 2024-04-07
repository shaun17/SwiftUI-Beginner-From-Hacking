//
//  Pro17Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/2.
//

import Combine
import SwiftUI
import UIKit

struct Pro17Part4: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    @Environment(\.scenePhase) var scenPhase

    @Environment(\.accessibilityDifferentiateWithoutColor) var diff

    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer, perform: { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                counter += 1
            })
            .onChange(of: scenPhase) { _, newValue in
                if newValue == .active {
                    print("Avtice")
                } else if newValue == .inactive {
                    print("Inactice")
                } else if newValue == .background {
                    print("Background")
                }
            }

        HStack {
            if diff {
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
        }
        .padding()
        .background(diff ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)

        Button("Hello World") {
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        .scaleEffect(scale)
    }

    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct Pro17Part4View: View {
    @Environment(\.accessibilityReduceMotion) var reduce
    var body: some View {
        Text("Hello World")
            .padding()
            .background(reduce ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(.capsule)
    }
}

#Preview {
    Pro17Part4()
}
