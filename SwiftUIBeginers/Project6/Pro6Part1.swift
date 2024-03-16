//
//  Pro5Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/15.
//

import SwiftUI

struct Pro6Part1: View {
    @State private var animationAmount1 = 1.0
    @State private var animationAmount2 = 1.0
    @State private var animationAmount3 = 0.0

    var body: some View {
        print(animationAmount1)

        return VStack {
            Section{
                Stepper("Scale amount", value: 
                            $animationAmount1.animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1 ... 10, step: 0.25)
                
                Button("Tap tap") {
                    
                }
                .padding(50)
                .background(.orange)
                .foregroundColor(.white)
                .clipShape(.circle)
                .scaleEffect(animationAmount1)

            }
            
            Section{
                Button("Tap tap") {
                    
                }
                .padding(50)
                .background(.orange)
                .foregroundColor(.white)
                .clipShape(.circle)
                            .overlay(Circle().stroke(.yellow)
                                .scaleEffect(animationAmount2)
                                .opacity(2 - animationAmount2)
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount2)
                            )
                            .onAppear(perform: {
                                animationAmount2 = 2
                            })
            }
            
            Section{
                Button("旋转") {
                    withAnimation(.spring(duration: 1, bounce: 0.5)) {
                        animationAmount3 += 360
                    }
                }
                .padding(50)
                .background(.orange)
                .foregroundColor(.white)
                .clipShape(.circle)
                .rotation3DEffect(
                    .degrees(animationAmount3),
                    axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                )
            }
        }
    }
}

#Preview {
    Pro6Part1()
}
