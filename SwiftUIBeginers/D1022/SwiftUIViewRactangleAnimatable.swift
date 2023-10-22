//
//  SwiftUIViewRactangleAnimatable.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/23.
//

import SwiftUI

struct RactangleDIY :Shape{
    var rows: Int
    var colums: Int
    var animatableData: AnimatablePair<Double,Double>{
        get{AnimatablePair(Double(rows), Double(colums))}
        set{
            rows = Int(newValue.first)
            colums = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rowSize = rect.height / Double(rows)
        let columSize = rect.width / Double(colums)
        for row in 0..<rows {
            for colum in 0..<colums{
                if (row+colum).isMultiple(of: 2){
                    let startX = columSize*Double(colum)
                    let startY = rowSize*Double(row)
                    let rect = CGRect(x: startX, y: startY, width: columSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
    
}

struct SwiftUIViewRactangleAnimatable: View {
    @State private var rows = 4
    @State private var colums = 4
    var body: some View {
        RactangleDIY(rows: rows, colums: colums)
            .onTapGesture {
                withAnimation {
                    rows=8
                    colums=18
                }
            }
    }
}

#Preview {
    SwiftUIViewRactangleAnimatable()
}
