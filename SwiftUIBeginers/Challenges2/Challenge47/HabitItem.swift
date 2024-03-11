//
//  HabitItem.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/30.
//

import Foundation

struct HabitItem: Identifiable, Codable{
    var id = UUID()
    var name: String
    var date: Date
    var think: String
    var time: Int
    
}
