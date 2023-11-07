//
//  SwiftUIViewOrder.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/7.
//

import SwiftUI

struct SwiftUIViewOrder: View {
    @StateObject var order = Order()
    
    var body: some View {
        
        NavigationView(content: {
            Form(content: {
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)

                }
                
                Section{
                    Toggle("Any special requests?", isOn: $order.specialRequestEnable)
                    
                    if order.specialRequestEnable {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
            })
            
            
        
            
            
        })
    }
}

#Preview {
    SwiftUIViewOrder()
}
