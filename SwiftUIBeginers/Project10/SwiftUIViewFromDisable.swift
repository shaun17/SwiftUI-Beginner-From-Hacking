//
//  SwiftUIViewFromDisable.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/6.
//

import SwiftUI

struct SwiftUIViewFromDisable: View {
    @State public var username = ""
    @State public var email = ""
    var disableFrom: Bool {
        username.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section{
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section{
                Button("Create account") {
                    print("Creating account…")
                }
                .disabled(disableFrom)

            }
        }
        
    }
}

#Preview {
    SwiftUIViewFromDisable()
}
