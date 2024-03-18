//
//  Pro8PoJO.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/18.
//

import SwiftUI

struct Astronaut: Codable, Identifiable{
    let id: String
    let name: String
    let description: String
}

extension Bundle{
    
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let dataformat = DateFormatter()
        dataformat.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dataformat)
        guard let load = try? decoder.decode(T.self, from: data) else{
            fatalError("Failed to decode \(file) from bundle.")
        }
        

        return load
    }
}


struct Mission: Codable, Identifiable{
    struct CrewRole: Codable{
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String{
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
