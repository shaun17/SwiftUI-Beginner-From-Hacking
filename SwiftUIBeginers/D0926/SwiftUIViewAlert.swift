//
//  SwiftUIViewAlert.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/26.
//

import SwiftUI

struct SwiftUIViewAlert: View {
    @State private var click = false
    var body: some View {
        Button("show alert") {
            click  = true
        }
        .alert("alert title", isPresented: $click, actions: {
            Button("NOOO", role: .cancel){
                print("this is NO")
            }
           
            Button("OKAY", role: .destructive){
                print("it is okay")
            }
        }, message: {
            Text("alert message ")
        })
        
    }
}

struct SwiftUIViewAlert_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewAlert()
    }
}
