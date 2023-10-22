//
//  SwiftUIViewImagePaint.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/17.
//

import SwiftUI

struct SwiftUIViewImagePaint: View {
    var body: some View {
        VStack{
            
            
            Text("Hello, World!")
                .frame(width: 300, height: 200)
                .border(ImagePaint(image: Image("apollo10"),sourceRect: CGRect(x: 0, y: 0, width: 0.2, height: 0.9), scale: 0.0004
                                  ),  width: 50)
           Capsule()
                .strokeBorder(ImagePaint(image: Image("apollo10"),sourceRect: CGRect(x: 0, y: 0.3, width: 1, height: 0.2), scale: 0.0004
                                  ),  lineWidth: 50)
                .frame(width: 300, height: 300)
        }
    }   
}

#Preview {
    SwiftUIViewImagePaint()
}
