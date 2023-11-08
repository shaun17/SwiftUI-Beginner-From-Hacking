//
//  Order_Project10.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/7.
//

import Foundation
import SwiftUI

class Order: ObservableObject {
    
    static let types = ["Chocolate","Strawberry","Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnable = false {
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool{
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    
    var cost: Double{
        var cost = Double(quantity * 2)
        
        cost += (Double(type) / 2 )
        
        if extraFrosting{
            cost += Double(quantity)
        }
        if addSprinkles{
            cost += Double(quantity) / 2
        }
        return cost
    }
}
