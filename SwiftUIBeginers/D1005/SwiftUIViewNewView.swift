//
//  SwiftUIViewNewView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/6.
//

import SwiftUI
struct SecondaryView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    @State private var numbers = Array(0 ... 10)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("hello Mr'\(name)")
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: { indexSet in
                        delete(indexSet)
                    })
                }
                
                HStack {
                    Button("Add one") {
                        numbers.append(Int.random(in: 0 ... 10))
                    }.buttonStyle(.borderedProminent)
                    
                    Button("Dismiss") {
                        dismiss()
                    }.buttonStyle(.borderedProminent)
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }

    func delete(_ index: IndexSet) {
        numbers.remove(atOffsets: index)
    }
}

struct SwiftUIViewNewView: View {
    @State private var siShow = false
    @State private var numbers = [Int]()
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {

                Text("Hello, World!")
                Button("Show Other Page") {
                    siShow.toggle()
                }.sheet(isPresented: $siShow, content: {
                        SecondaryView(name: "Tom")
                    })
                
            })
            
        })
    }
}

#Preview {
    SwiftUIViewNewView()
}
