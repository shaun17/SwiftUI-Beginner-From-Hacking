//
//  SwiftUIView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/5.
//

import SwiftUI

class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct SwiftUIViewStruct: View {
    @State private var user = User()
    
    var body: some View {
        VStack{
            Text("Your name \(user.firstName) \(user.lastName)")
            
            TextField("the first name", text: $user.firstName)
            TextField("the last name", text: $user.lastName)
        }
        .onAppear(){
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
