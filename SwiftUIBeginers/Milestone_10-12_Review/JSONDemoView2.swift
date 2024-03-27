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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)

        let stringAge = try container.decode(String.self, forKey: .age)
        self.age = Int(stringAge) ?? 0
    }
  
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(String(self.age), forKey: .age)
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
