//
//  CheckoutView_Project10.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/8.
//

import SwiftUI

struct CheckoutView_Project10: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string:  "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){  image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            
            
            Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                .font(.title)
            Button("Place Order") {
                Task{
                    await placeOrder()
                }
            }
            .padding()
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thanks you", isPresented: $showingConfirmation) {
            Button("OK"){
                
            }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Fail to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print(String(data: data, encoding: .utf8) ?? "")
            let decoder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Yout order for \(decoder.quantity)x \(Order.types[decoder.type].lowercased()) cupcakes is on its way"
            showingConfirmation = true
            
        } catch {
            print("Check failed")
        }
    }
}

#Preview {
    CheckoutView_Project10(order: Order())
}
