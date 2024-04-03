//
//  Pro17Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/2.
//

import SwiftUI

struct Pro17Part4: View {
    let timer = Timer.publish(every: 1,tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    @Environment(\.scenePhase) var scenPhase
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var diff
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer, perform: { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                counter += 1
            })
            .onChange(of: scenPhase) { oldValue, newValue in
                if newValue == .active {
                    print("Avtice")
                } else if newValue == .inactive {
                    print("Inactice")
                } else if newValue == .background {
                    print("Background")
                }
            }
        
        
        HStack{
            if diff {
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
        }
        .padding()
        .background(diff ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}

#Preview {
    Pro17Part4()
}
