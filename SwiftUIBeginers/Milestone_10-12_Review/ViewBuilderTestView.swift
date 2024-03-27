//
//  ViewBuilderTestView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/22.
//

import SwiftUI

extension View {
    
    
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
struct ViewBuilderTestView: View {
    var randomText: some View {
        
            if Bool.random() {
                return Text("Hello, World2!")
                    .frame(width: 300)
                    .eraseToAnyView()
            } else {
                
                return Text("Hello, World2!")
                    .eraseToAnyView()
                    
            }
        }

    var body: some View {
        randomText
    }
}

#Preview {
    ViewBuilderTestView()
}
