//
//  SwiftUIView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/5.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct User2 {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct SwiftUIViewStruct: View {
    @StateObject var user = User()
    @State private var user2 = User2()

    var body: some View {
        VStack {
            Section{
                Text("Your name \(user.firstName) \(user.lastName)")
                
                TextField("the first name", text: $user.firstName)
                TextField("the last name", text: $user.lastName)

            }
            Section{
                Text("Your name  a \(user2.firstName) \(user2.lastName)")

                TextField("the first name", text: $user2.firstName)
                TextField("the last name", text: $user2.lastName)
            }
            
          
        }
        .onAppear {
            print(user.firstName)
        }
        .onSubmit {
            print(user.firstName)
        }
    }
}

#Preview {
    SwiftUIViewStruct()
}
