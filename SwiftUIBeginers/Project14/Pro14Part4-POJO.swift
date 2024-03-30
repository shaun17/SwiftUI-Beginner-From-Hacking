//
//  Pro14Part4-POJO.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/30.
//

import SwiftUI

struct ResultPro14: Codable {
    let query: QueryPro14
}

struct QueryPro14: Codable {
    let pages: [Int: PagePro14]
}

struct PagePro14: Codable, Comparable {
    static func < (lhs: PagePro14, rhs: PagePro14) -> Bool {
        lhs.title < rhs.title
    }
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }

    
}

struct Pro14Part4_POJO: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Pro14Part4_POJO()
}
