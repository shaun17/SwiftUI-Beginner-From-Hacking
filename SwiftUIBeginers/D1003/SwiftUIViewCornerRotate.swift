//
//  SwiftUIViewCornerRotateModifier.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/4.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier{
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
    
}


extension AnyTransition{
    static var pp: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}


struct SwiftUIViewCornerRotate: View {
    @State private var isShow = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(.yellow)
                .frame(width: 200, height: 200)
            
            if isShow {
                
                Rectangle()
                    .fill(.green)
                    .frame(width: 200, height: 200)
                    .transition(.pp)
            }
        }
        .onTapGesture {
            withAnimation {
                isShow.toggle()
            }
        }
    }
}

#Preview {
    SwiftUIViewCornerRotate()
}
