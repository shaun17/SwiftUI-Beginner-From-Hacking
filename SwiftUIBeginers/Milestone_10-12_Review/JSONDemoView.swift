//
//  JSONDemoView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/23.
//

import SwiftUI

class JsonUserReview: Codable{
    var firstName: String
    var lastName: String
}

struct JSONDemoView: View {

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: method) {
            Label(
                title: { /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/ },
                icon: { Image(systemName: "42.circle") }
            )
        }
    }
    
    func method(){
        let str = """
        {
            "first_name": "Andrew",
            "last_name": "Glouberman"
        }
        """

        let data = Data(str.utf8)

        do {
            let decoder = JSONDecoder()
            // 蛇形和驼峰转换
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let user = try decoder.decode(JsonUserReview.self, from: data)
            print("Hi, I'm \(user.firstName) \(user.lastName)")
        } catch {
            print("Whoops: \(error.localizedDescription)")
        }
    }
}

#Preview {
    JSONDemoView()
}
