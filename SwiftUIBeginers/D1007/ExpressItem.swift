//
//  ExpressItem.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/7.
//

import Foundation

struct ExpressItem: Identifiable, Codable{
    var id = UUID()
    var name: String
    var age: Int
    var type: String
}
