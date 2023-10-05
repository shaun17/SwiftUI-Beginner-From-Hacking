//
//  SwiftUIViewGesture.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/3.
//

import SwiftUI

struct SwiftUIViewGesture: View {
    let letters = Array("Hello SwiftUI")
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    @State private var dragAmount2 = CGSize.zero
    @State private var isShow = true

    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShow.toggle()
                }
                
            }
            .buttonStyle(.borderedProminent)
            
            if isShow { 
                LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .offset(dragAmount)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .gesture(
                    DragGesture()
                        .onChanged { a in
                            dragAmount = a.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                dragAmount = .zero
                            }
                        }
                )
            }
            
            HStack(spacing: 0) {
                ForEach(0 ..< letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(3)
                        .font(.title)
                        .clipShape(Circle())
                        .background(enabled ? .green : .blue)
                        .offset(dragAmount2)
                        .animation(.default.delay(Double(num) / 20), value: dragAmount2)
                }
            }
            .gesture(DragGesture().onChanged { dragAmount2 = $0.translation }
                .onEnded { _ in
                    dragAmount2 = .zero
                    enabled.toggle()
                })
        }
    }
}

#Preview {
    SwiftUIViewGesture()
}
