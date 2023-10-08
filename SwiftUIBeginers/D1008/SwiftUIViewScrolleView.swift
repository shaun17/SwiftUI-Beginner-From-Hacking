//
//  SwiftUIViewScrolleView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/8.
//

import SwiftUI

struct CustomText: View{
    let text: String
    var body: some View{
        Text("item is \(text)")
    }
    
    init(_ text: String) {
        print("\(text) is creating")
        self.text = text
    }
}

struct SwiftUIViewScrolleView: View {
    var body: some View {
        
    ScrollView(.vertical){
            LazyVStack(spacing: 10){
                ForEach(0..<100){
                    CustomText("\($0)")
                        .font(.title)
                }
            }.frame(maxWidth: .infinity)
        }
        
    }
}

#Preview {
    SwiftUIViewScrolleView()
}
