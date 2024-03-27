//
//  JSONDemoView2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/26.
//

import SwiftUI


struct JsonUserReview2: Codable{
    enum CodingKeys: String, CodingKey{
        case firstName = "first"
        case lastName = "last"
        case age
    }
    
    var firstName: String
    var lastName: String
    var age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

struct JSONDemoView2: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    JSONDemoView2()
}
