//
//  SwiftUIViewBlurs.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/22.
//

import SwiftUI

struct SwiftUIViewBlurs: View {
    @State private var amount = 0.0
    @State private var showView = false
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Circle()
                        .fill(Color(red: 1, green: 0, blue: 0))
                        .frame(width: 200 * amount)
                        .offset(x: -50, y: -80)
                        .blendMode(.screen)
                    Circle()
                        .fill(Color(red: 0, green: 1, blue: 0))
                        .frame(width: 200 * amount)
                        .offset(x: 50, y: -80)
                        .blendMode(.screen)
                    Circle()
                        .fill(Color(red: 0, green: 0, blue: 1))
                        .frame(width: 200 * amount)
                        .blendMode(.screen)
                    
                }
                .frame(width: 300, height: 300)
                
                Slider(value: $amount)
                    .padding()
            }
            .frame(width: .infinity, height: .infinity)
            .background(.black)
            .ignoresSafeArea()
            .toolbar(content: {
                Button("aa", systemImage: "plus") {
                    showView.toggle()
                }
            })
            .sheet(isPresented: $showView, content: {
                SwiftUIViewPicBlurs()
            })
            
        }
        
    }
}

#Preview {
    SwiftUIViewBlurs().preferredColorScheme(.dark)
}
