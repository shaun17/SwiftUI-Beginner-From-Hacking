//
//  Pro7Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/2.
//

import SwiftUI

struct Pro17Part1: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        currentAmount = value.rotation
                    }
                    .onEnded { value in
                        finalAmount += currentAmount
                        currentAmount = .zero
                        print("RotateGesture: \(value) !")
                    }
            )
            .onTapGesture(count: 2, perform: {
                print("Hello World")
            })
//            .onLongPressGesture {
//                print("Long Tap")
//            }
            .onLongPressGesture(minimumDuration: 2) {
                print("2 seconds")
            } onPressingChanged: { inpress in
                print("In progress: \(inpress)!")
            }
    }
}

struct Pro17Part1_bak: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped")
                }
        )
    }
}

#Preview {
    Pro17Part1_bak()
}
