//
//  Pro9Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/18.
//

import SwiftUI
struct DataDetail: View {
    @Binding var path: [Int]
    let number: Int
    var body: some View {
        NavigationLink("Go to a random number", value: Int.random(in: 0..<1000))
            .navigationTitle("Number \(number)")
            .toolbar(content: {
                Button("Home") {
                    path.removeAll()
                }
            })
    }
}

struct DataDetail2: View {
    @Binding var path: NavigationPath
    let number: Int
    var body: some View {
        VStack {
            let random = Int.random(in: 0..<1000)
            Button("Push \(random)") {
                path.append(random)
            }
        }
        .navigationTitle("Number \(number)")
        .toolbar(content: {
            Button("Home") {
                path = NavigationPath()
            }
        })
    }
}

struct Pro9Part2: View {
    @State private var path = [Int]()
    @State private var path2 = NavigationPath()

    var body: some View {
        NavigationStack(path: $path2) {
//            DataDetail(path: $path ,number: 0)
//                .navigationDestination(for: Int.self) { i in
//                    DataDetail(path: $path, number: i)
//                }
            DataDetail2(path: $path2, number: 0)
                .navigationDestination(for: Int.self) { i in
                    DataDetail2(path: $path2, number: i)
                }
        }
    }
}

#Preview {
    Pro9Part2()
}
