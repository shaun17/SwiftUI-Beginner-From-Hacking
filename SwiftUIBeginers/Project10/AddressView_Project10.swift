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
            Form{
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("zip", text: $order.zip)
                }
                
                Section {
                    NavigationLink {
                        CheckoutView_Project10(order: order)
                    } label: {
                        Text("Check Out")
                    }
                    .disabled(!order.hasValidAddress)
                }
            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationView(content: {
        AddressView_Project10(order: Order())

    })
}
