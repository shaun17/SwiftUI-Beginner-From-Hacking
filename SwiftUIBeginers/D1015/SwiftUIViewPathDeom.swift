//
//  SwiftUIViewPathDeom.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/15.
//

import SwiftUI

struct Triangle: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX,y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Rectanglediy: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

        return path
    }
}

struct SwiftUIViewPathDeom: View {
    var body: some View {
        
        Triangle()
            .stroke(.blue, style: StrokeStyle(lineWidth: 15,lineCap: .round, lineJoin: .round))
            .frame(width: 100, height: 100  )
            .border(.green)
        
        Rectanglediy()
            .fill(.red)
//            .stroke(style: StrokeStyle(lineWidth: 10,lineCap: .round, lineJoin: .round))
//            .border(.green, width: 10)
         
        Path{ path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
        }
        .stroke(.green ,style: StrokeStyle(lineWidth: 10,lineCap: .round, lineJoin: .round))
        
    }
}

#Preview {
    SwiftUIViewPathDeom()
}
