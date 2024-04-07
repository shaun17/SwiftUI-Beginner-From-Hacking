//
//  Pro6Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/15.
//

import SwiftUI

struct ConerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: ConerRotateModifier(amount: -90, anchor: .topLeading), identity: ConerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct Pro6Part2: View {
    let letters = Array("Hello SwiftUI")

    @State private var enabled = false
    @State private var isShowingRed = false
    @State private var isShowingRed2 = false
    @State private var dragAmount = CGSize.zero
    @State private var dragAmount2 = CGSize.zero

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed2.toggle()
            }
        }

        Button("Tap tap") {
            withAnimation {
                isShowingRed.toggle()
                isShowingRed2.toggle()
            }
        }
        if isShowingRed {
            Rectanglediy()
                .fill(.red)
                .frame(width: 100, height: 100)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
        }
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .foregroundStyle(.white)
        .animation(nil, value: enabled)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.5), value: enabled)

        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 50, height: 50)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(DragGesture()
                .onChanged { drag in
                    withAnimation(.smooth) {
                        dragAmount = drag.translation
                    }
                }
                .onEnded { _ in
                    withAnimation(.bouncy) {
                        dragAmount = .zero
                    }
                })
        //            .animation(.bouncy, value: dragAmount)

        HStack {
            ForEach(0 ..< letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .font(.title.bold())
                    .background(LinearGradient(colors: [.yellow, .pink], startPoint: .topLeading, endPoint: .bottomTrailing).frame(width: 28)
                        .clipShape(.rect(cornerRadius: 10))
                        .opacity(0.32))
                    .foregroundColor(enabled ? .black : .blue)
                    .offset(dragAmount2)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount2)
                    .gesture(DragGesture().onChanged { drag in
                        dragAmount2 = drag.translation
                    }
                    .onEnded { _ in
                        withAnimation(.smooth) {
                            dragAmount2 = .zero
                            enabled.toggle()
                        }

                    })
            }
        }
    }
}

#Preview {
    Pro6Part2()
}
