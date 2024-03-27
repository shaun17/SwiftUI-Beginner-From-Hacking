//
//  Pro8Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/17.
//

import SwiftUI

struct UserInfoPro8: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct Pro8Part2: View {
    let layout = [
        GridItem(.adaptive(minimum: 120, maximum: 240))

    ]
    var body: some View {
        
        ScrollView(.horizontal){
            LazyHGrid(rows: layout, content: {
                ForEach(0..<100) {
                    Text("Item \($0)")

                }
                
            })
        }
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(UserInfoPro8.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

#Preview {
    Pro8Part2()
}
