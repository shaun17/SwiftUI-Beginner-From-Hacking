//
//  SwiftUIViewAmazingSpirograph.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/23.
//

import SwiftUI

struct Spirogtaph: Shape{
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    func gbc(_ a:Int, _ b: Int) -> Int{
        var a = a
        var b = b
        while b != 0{
            let temp = b
            b = a % b
            a = temp
        }
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gbc(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint =  ceil(2 * Double.pi * outerRadius/Double(divisor))*amount
        
        
        var path = Path()
        
        for theta in stride(from: 0, to: endPoint, by: 0.01){
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
                
            }else{
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
        }
        return path
        
    }
}

struct SwiftUIViewAmazingSpirograph: View {
    @State private var innerRadius = 125.0
        @State private var outerRadius = 75.0
        @State private var distance = 25.0
        @State private var amount = 1.0
        @State private var hue = 0.6
    var body: some View {
        VStack(spacing: 0) {
                   Spacer()

            Spirogtaph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                       .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                       .frame(width: 300, height: 300)

                   Spacer()

                   Group {
                       Text("Inner radius: \(Int(innerRadius))")
                       Slider(value: $innerRadius, in: 10...150, step: 1)
                           .padding([.horizontal, .bottom])

                       Text("Outer radius: \(Int(outerRadius))")
                       Slider(value: $outerRadius, in: 10...150, step: 1)
                           .padding([.horizontal, .bottom])

                       Text("Distance: \(Int(distance))")
                       Slider(value: $distance, in: 1...150, step: 1)
                           .padding([.horizontal, .bottom])

                       Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                       Slider(value: $amount)
                           .padding([.horizontal, .bottom])

                       Text("Color")
                       Slider(value: $hue)
                           .padding(.horizontal)
                   }
               }
    }
}

#Preview {
    SwiftUIViewAmazingSpirograph()
}
