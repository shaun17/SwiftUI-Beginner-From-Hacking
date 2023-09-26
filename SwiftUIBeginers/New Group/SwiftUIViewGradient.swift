//
//  SwiftUIViewGradient.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/26.
//

import SwiftUI

struct SwiftUIViewGradient: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .yellow], startPoint: .top, endPoint: .bottom)
            
            RadialGradient(gradient: Gradient(colors: [.yellow, .blue]), center: .center, startRadius: 40, endRadius: 250)
            
            Text("Ukraine")
                .foregroundColor(.secondary)
                .font(.title)
                .bold()
            
        }.ignoresSafeArea()
    }
}

struct SwiftUIViewGradient_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGradient()
    }
}
