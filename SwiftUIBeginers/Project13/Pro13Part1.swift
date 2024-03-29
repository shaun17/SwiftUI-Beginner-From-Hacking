//
//  Pro13Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/28.
//

import SwiftUI

struct Pro13Part1: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }

    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white

    var body: some View {
        VStack {
            Text("Hello World")
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { _, newValue in
                    print("New value is \(newValue)")
                }
            Button("Random blur") {
                blurAmount = Double.random(in: 0...20)
            }

            Button("Hello World") {
                showingConfirmation = true
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .confirmationDialog("Change BackgroundColor", isPresented: $showingConfirmation) {
                Button("Red") {
                    backgroundColor = .red
                }
                Button("Green") {
                    backgroundColor = .green
                }
                Button("Yellow") {
                    backgroundColor = .yellow
                }
            } message: {
                Text("Select One")
            }
        }
    }
}

#Preview {
    Pro13Part1()
}
