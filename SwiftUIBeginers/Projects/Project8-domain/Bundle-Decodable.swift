//
//  Bundle-Decodable.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/9.
//

import Foundation

extension Bundle{
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("failed to load \(file) from bundle")
        }
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let result = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from bundle")
        }
        return result
        
    }
}
