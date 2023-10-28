//
//  ChallengeNineArrow.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/26.
//

import SwiftUI

struct Arrow: Shape{
    var index_x: Double
    var index_y: Double

    func path(in rect: CGRect) -> Path {
        let average  = rect.maxX/10
        let averageY  = rect.maxY/10
        let change  = average * index_x
        let changeY  = averageY * index_y
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY-5*changeY))
        path.addLine(to: CGPoint(x: rect.midX - 3*change, y: rect.midY-changeY))
        path.addLine(to: CGPoint(x:rect.midX - change, y: rect.midY-changeY))
        path.addLine(to: CGPoint(x: rect.midX - change, y: rect.midY+5*changeY))
        path.addLine(to: CGPoint(x: rect.midX + change, y: rect.midY+5*changeY))
        path.addLine(to: CGPoint(x: rect.midX + change, y: rect.midY-changeY))
        path.addLine(to: CGPoint(x: rect.midX + 3*change, y: rect.midY-changeY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY-5*changeY))
        return path
    }
}

struct ChallengeNineArrow: View {
    @State private var index_x = 1.0
    @State private var index_y = 1.0
    var body: some View {
        Arrow(index_x: index_x,index_y: index_y)
            .frame(width: 300, height: 300)
        Text("Coordinates X")
        Slider(value: $index_x, in: 0...2)
        Text("Coordinates Y")
        Slider(value: $index_y, in: 0...2)
    }
}

#Preview {
    ChallengeNineArrow()
}
