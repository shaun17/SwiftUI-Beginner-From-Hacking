//
//  SwiftUIViewCG.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/16.
//

import SwiftUI
struct Flower: Shape{
    var petalOffset: Double
    var petalWidth: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
       
        for nubmer in stride(from: 0, to: Double.pi * 2, by: Double.pi/8) {
            let rotation = CGAffineTransform(rotationAngle: nubmer)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.midX, y: rect.midY))
                                                
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.midX))
            let rotationPetal = originalPetal.applying(position)
            path.addPath(rotationPetal)
            
        }
        return path
    }
}

struct SwiftUIViewCG: View {
    @State private var petalOffset  = 0.0
    @State private var petalWidth = 40.0
    var body: some View {
        
        Flower(petalOffset: petalOffset, petalWidth: petalWidth)
            .fill(.green, style: FillStyle(eoFill: true))
            .frame(width: 200, height: 200)
            .border(.black)
        
        Text("OffSet")
        Slider(value: $petalOffset, in: -40...20)
            .padding([.horizontal, .bottom])
        Text("Width")
        Slider(value: $petalWidth, in: 0...100)
            .padding([.horizontal, .bottom])
      
    }
}

#Preview {
    SwiftUIViewCG()
}
