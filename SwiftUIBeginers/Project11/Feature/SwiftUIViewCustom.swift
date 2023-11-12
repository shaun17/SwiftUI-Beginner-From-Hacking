//
//  SwiftUIViewCustom.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/10.
//

import SwiftUI


struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColor = [Color.red, Color.yellow]
    var offColor = [Color(white: 0.4), Color(white: 0.6)]
    
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColor : offColor), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
        
    }
}

struct SwiftUIViewCustom: View {
    @State private var remeberme = false
    var body: some View {
        VStack{
            PushButton(title: "Remeber ME", isOn: $remeberme)
            Text(remeberme ? "On": "Off")
        }
    }
}

#Preview {
    SwiftUIViewCustom()
}
