//
//  SwiftUIViewPicBlurs.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/22.
//

import SwiftUI

struct SwiftUIViewPicBlurs: View {
    @State private var amount=0.0
    var body: some View {
        VStack{
            Image("apollo13")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1-amount) * 20)
            
            Slider(value: $amount)
        }
        
    }
}

#Preview {
    SwiftUIViewPicBlurs()
}
