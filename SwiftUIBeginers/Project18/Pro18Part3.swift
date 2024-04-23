//
//  Pro18Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/10.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top").padding()
            InnerView()
                .background(.green)
            Text("Bottom").padding()
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")

            GeometryReader(content: { proxy in
                Text("Content")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                        print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                        print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                        print("=============================")
                    }
            })
            .background(.orange)
            Text("Right")
        }
    }
}

struct Pro18Part3: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

#Preview {
    Pro18Part3()
}
