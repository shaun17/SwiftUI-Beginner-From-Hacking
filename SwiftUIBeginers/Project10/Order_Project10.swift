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
    
    @Published var specialRequestEnable = false
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
