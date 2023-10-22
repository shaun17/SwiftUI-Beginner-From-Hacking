//
//  SwiftUIViewColorCircular.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/22.
//

import SwiftUI

struct CircularLiner : View {
     var stapes = 100
     var amount = 0.0
    
    
    var body: some View {
        ZStack{
            ForEach(0..<stapes){ value in
                Circle()
                    .inset(by: CGFloat(Double(value)))
                    .strokeBorder(
                        
                        LinearGradient(gradient: Gradient(colors: [
                            color(value: value, brightness: 1),
//                            color(value: value, brightness: 0.5)

                        ]), startPoint: .top
                                       , endPoint: .bottom)
                       
                    )
            }
        }
        .drawingGroup()
            
    }
    
    func color(value :Int, brightness: Double) ->Color{
        var targetHue = Double(value)/Double(stapes) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
        
    }
}

struct SwiftUIViewColorCircular: View {
    @State private var colorCycle = 0.0
    var body: some View {
        VStack{
            CircularLiner(amount: colorCycle)
                .frame(width: 200, height: 200)
            
            Slider(value: $colorCycle)
        }
        
    }
}

#Preview {
    SwiftUIViewColorCircular()
}
