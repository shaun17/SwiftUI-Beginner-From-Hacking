//
//  SwiftUIViewAnimation.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/3.
//

import SwiftUI

struct SwiftUIViewAnimation: View {
    @State private var amount1 = 1.0
    @State private var amount = 1.0
    @State private var amount3 = 1.0
    @State private var animationAmount = 0.0

    var body: some View {
        VStack {
            Button("Clikc") {
                amount1 += 1
            }
            .padding(30)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(amount1)
            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: amount1)
            .blur(radius: (amount1 - 1) * 1)
            
            Button("Clikc") {}
                .padding(30)
                .background(.green)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(content: {
                    Circle()
                        .stroke(.yellow)
                        .scaleEffect(amount)
                        .opacity(2 - amount)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: amount)
                })
                .onAppear(perform: {
                    amount = 2
                })
            
            Stepper("case 3", value: $amount3.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3)), in: 0 ... 10)
            Button("click me") {
                amount3 += 1
            }
            .padding(30)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(amount3)
            
            Button("click me") {
                withAnimation(.interpolatingSpring(stiffness: 3, damping: 1)) {
                    animationAmount += 360
                }
            }
            .padding(30)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(animationAmount),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
        }
    }
}

#Preview {
    SwiftUIViewAnimation()
}
