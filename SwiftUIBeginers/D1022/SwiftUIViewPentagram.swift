//
//  SwiftUIViewPentagram.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/22.
//

import SwiftUI
struct Pentagram: Shape{
        
        var index: Double
        var fromAngle: Double
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
           
            for nubmer in stride(from: fromAngle, to: Double.pi * 2, by: (Double.pi*2)/5) {
                let rotation = CGAffineTransform(rotationAngle: nubmer)
                let position = rotation.concatenating(CGAffineTransform(translationX: rect.midX, y: rect.midY))
                
                let original = Path(CGMutablePath(roundedRect: CGRect(x: 30*index, y: -100*index, width: 5*index, height: 200*index), cornerWidth: 5*index, cornerHeight: 5*index, transform: nil))
                                
                let rotationPetal = original.applying(position)
                path.addPath(rotationPetal)
                
            }
            return path
        }
}

struct SwiftUIViewPentagram: View {
    @State private var index  = 0.5
    @State private var fromAngle  = 0.5
    var body: some View {
        Pentagram(index: index, fromAngle: fromAngle)
            .frame(width: 200, height: 200)
            
        Slider(value: $index)
        Slider(value: $fromAngle,in: -2...1)
    }
}

#Preview {
    SwiftUIViewPentagram()
}
