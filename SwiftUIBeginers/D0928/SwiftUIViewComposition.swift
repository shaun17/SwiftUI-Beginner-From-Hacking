//
//  SwiftUIViewComposition.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/28.
//

import SwiftUI

struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
            .padding()
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func titleStyle() -> some View{
        modifier(Title())
    }
}

struct Watermark: ViewModifier{
    var msg: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
                   content
                   Text(msg)
                       .font(.caption)
                       .foregroundColor(.white)
                       .padding(10)
                       .background(.black)
                       .padding(10)
                       .background(.yellow)
                       .padding(10)
                       .background(.blue)
                       .padding(10)
                       .background(.green)
            
               }
    }
}


extension View {
    func watermarked(_ msg: String) -> some View{
        modifier(Watermark(msg: "HIiiiiiiiiii"))
    }
}

struct GridStack<Content: View>: View{
    var rows: Int
    var columns: Int
    var context: (Int, Int) -> Content
    var body: some View{
        VStack{
            ForEach(0..<rows, id: \.self){row in
                HStack{
                    ForEach(0..<columns, id: \.self){column in
                        context(row, column)
                            .padding(4)
                            .background(.green)
                            .foregroundColor(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                
            }
        }
        
        
    }
}


struct SwiftUIViewComposition: View {
    
    var body: some View {
        VStack{
            Text("Hello World1")
                .modifier(Title())
            Text("Hello World2")
                .titleStyle()
            Color.red
                .frame(width: 200, height: 200)
                .watermarked("HI")
            
            GridStack(rows: 5, columns: 5) { row, column in
              Text("\(row) + \(column)")
            }
        }
       
    }
}


struct SwiftUIViewComposition_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewComposition()
    }
}
