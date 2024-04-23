//
//  Pro18Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/9.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct Pro18Part2: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("Hello World")
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(.example)
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }

                Text("Hello World")
                    .font(.headline
                    )
            }
        }

        VStack(alignment: .leading, content: {
            ForEach(0 ..< 10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in Double(position) * -10 }
            }

        })
        .background(.red)
        .frame(width: 200, height: 200)
        .background(.blue)
    }
}

#Preview {
    Pro18Part2()
}
