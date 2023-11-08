//
//  SwiftUIViewAddressView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/8.
//

import SwiftUI

struct AddressView_Project10: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddressView_Project10(order: Order())
}
