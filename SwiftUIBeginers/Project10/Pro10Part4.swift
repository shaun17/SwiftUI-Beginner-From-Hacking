//
//  Pro10Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/21.
//

import SwiftUI

@Observable
class UserPro10: Codable{
    enum CodingKeys: String, CodingKey{
        case _name = "name"
    }
    var name = "Taylor"
}
struct Pro10Part4: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    func encodeTaylor() {
       let data = try! JSONEncoder().encode(UserPro10())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    Pro10Part4()
}
