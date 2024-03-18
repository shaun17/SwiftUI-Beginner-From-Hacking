//
//  Pro8Pat1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/17.
//

import SwiftUI

struct Pro8Pat1: View {
    var body: some View {
        NavigationStack {
            Image(.anders)
                .resizable()
                .scaledToFit()
//            .scaleEffect(0.8)
                .containerRelativeFrame(.horizontal) { size, _ in
                    size * 0.8
                }
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(0..<100) {
                        CustomText(String($0))
                            .font(.title)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            NavigationLink {
                Text("Detail View")
            } label: {
                VStack {
                    Text("This is the label")
                    Text("So is this")
                    Image(systemName: "face.smiling")
                }
                .font(.largeTitle)
            }

            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

#Preview {
    Pro8Pat1()
}
