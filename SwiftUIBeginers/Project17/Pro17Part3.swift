//
//  Pro17Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/2.
//

import SwiftUI

struct Pro17Part3: View {
    var body: some View {
        VStack{
            Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped")
        }
        
        
        ZStack{
            
            Rectangle()
                .fill(.blue)
                .frame(width: 300,height: 300)
                .onTapGesture {
                    print("Ractangle tapped")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
//                .contentShape(.rect)
                .onTapGesture {
                    print("Circle tapped")
                }
//                .allowsHitTesting(false)

        }
    }
}

#Preview {
    Pro17Part3()
}
