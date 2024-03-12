//
//  Pro3Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/12.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.pink)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View{
    func diyTitle() -> some View{
        modifier(Title())
    }
}


struct Watermark: ViewModifier{
    var txt: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
                    content
                    Text(txt)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(5)
                        .background(.black)
                }
    }
}

extension View{
    func diyWatermark(_ txt: String)-> some View{
        modifier(Watermark(txt:txt))
    }
}

struct Pro3Part1: View {
    @State private var changeColor = false
    var body: some View {
        VStack{
            
            Button("Hello, world!") {
                changeColor.toggle()
            }
            .frame(width: 200, height: 200)
            .background(changeColor ? .red : .green)
            
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                    .blur(radius: 3)
                Text("Hufflepuff")
                Text("Ravenclaw")
                    .diyTitle()
                Text("Slytherin")
                    .modifier(Title())
                
            }
            .font(.title)
            .blur(radius: 1.0)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .ignoresSafeArea()
        .diyWatermark("Hacking with Swift")
    

    }
}

#Preview {
    Pro3Part1()
}
