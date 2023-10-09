//
//  Mission.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/9.
//

import Foundation

struct Mission: Codable, Identifiable{
    
    struct Crew: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [Crew]
    let description: String
    
    
    var displayName: String{
        "Apollo \(id)"
    }
    var image: String{
        "apollo\(id)"
    }
    var displayLaunchDate: String{
        self.launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    
}
