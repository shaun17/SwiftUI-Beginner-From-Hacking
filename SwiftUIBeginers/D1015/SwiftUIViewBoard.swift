//
//  SwiftUIViewBoard.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/15.
//

import SwiftUI
struct Arc: InsettableShape{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let modify = Angle(degrees: 90)
        let modifyStartAngle  = startAngle - modify
        let modifyEndAngle  = endAngle - modify
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY), radius: rect.width/2 - insetAmount, startAngle: modifyStartAngle, endAngle: modifyEndAngle, clockwise: clockwise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape{
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct SwiftUIViewBoard: View {
    var body: some View {
        
        Arc(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
            .strokeBorder(lineWidth: 40)
            .frame(width: .infinity, height: 100)
        
           
        
     
//        Circle()
//            .strokeBorder(style: StrokeStyle(lineWidth: 50))
    }
}

#Preview {
    SwiftUIViewBoard()
}
