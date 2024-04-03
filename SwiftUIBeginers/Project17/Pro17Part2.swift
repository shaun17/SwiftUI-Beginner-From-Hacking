//
//  Pro7Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/2.
//

import SwiftUI

struct Pro17Part2: View {
    @State private var offSet = CGSize.zero
    @State private var isDragging = false
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offSet = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offSet = .zero
                    isDragging = false
                }
            }

        let longPressGesture = LongPressGesture()
            .onEnded { _ in
                withAnimation {
                    offSet = .zero
                    isDragging = false
                }
            }
        let combine = longPressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offSet)
            .gesture(combine)
    }
}

#Preview {
    Pro17Part2()
}
