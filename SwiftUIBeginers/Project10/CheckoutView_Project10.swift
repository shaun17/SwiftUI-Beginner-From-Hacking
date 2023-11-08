//
//  CheckoutView_Project10.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/8.
//

import SwiftUI

struct CheckoutView_Project10: View {
    @ObservedObject var order: Order
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string:  "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){  image in
                image
                    .resizable()
                    .scaledToFill()
            }
            placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            
            
            Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                .font(.title)
            Button("Place Order") {
                
            }
            .padding()
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CheckoutView_Project10(order: Order())
}
