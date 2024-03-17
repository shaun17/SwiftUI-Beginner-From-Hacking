//
//  SwiftUIViewCodableTo Learn.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/5.
//

import SwiftUI

struct SwiftUIViewCodableToLearn: View {
    
    class User2: ObservableObject, Codable{
        
        enum CodingKeys: CodingKey{
            case name
        }
        
        @Published var name = "User's name"
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
        }
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SwiftUIViewCodableToLearn()
}
