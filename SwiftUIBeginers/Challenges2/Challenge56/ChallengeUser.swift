//
//  ChallengeUser.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/24.
//

import Foundation


struct ChallengeUser: Codable, Identifiable{
    var id: UUID
    var name: String
    var age: Int
    var company: String
    var isActive: Bool
    var email: String
    var address: String
    var registered: Date
    var about: String
    var tags: [String]
    var friends: [ChallengeFriend]
    
    var formattedDate: String{
        registered.formatted(date: .abbreviated, time: .omitted)
    }
    
}

struct ChallengeFriend: Codable, Identifiable{
    var id: UUID
    var name: String
}
