//
//  Express.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/7.
//

import Foundation

class Express: ObservableObject {
    
    @Published var expressItems = [ExpressItem](){
        didSet {
            if  let encoded = try? JSONEncoder().encode(expressItems){
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init(){
        if let saveItems = UserDefaults.standard.data(forKey: "items"){
            if let decode = try? JSONDecoder().decode([ExpressItem].self, from: saveItems){
                expressItems = decode
                return
            }
        }
        expressItems = []
    }
    
}
