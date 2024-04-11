//
//  Pro18Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/8.
//

import SwiftUI

struct Pro18Part1: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Placeholder")
            Text("This is a longer line of Text")
        })
        .background(.red)
        .frame(width: 200, height: 200)
        .background(.blue)
        
        VStack(alignment: .leading, content: {
            Text("Placeholder")
                .alignmentGuide(.leading, computeValue: { dimension in
                    dimension[.leading]
                })
        })
        HStack(alignment: .bottom, content: {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)

        })

        Text("Hello, World!")
            .frame(width: 300, height: 300, alignment: .leading)
            .padding()
            .background(.red)
    }
}

#Preview {
    Pro18Part1()
}
