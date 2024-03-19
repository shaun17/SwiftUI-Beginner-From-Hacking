//
//  Pro7Part5-Challenge.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/19.
//

import SwiftUI

struct Pro7Part5_Challenge: View {

    
    var expenses: Expense_Challenge
    
    let types = ["Business", "Personal"]
    
    @State private var name = "Change name"
    @State private var type = "Business"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        NavigationStack{
            Form{
//                TextField("input your name", text: $name)
                Picker("select your type", selection: $type) {
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("input your Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button("Save") {
                    let item = ExpenseItem_Challenge(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            })

        }
    }
}

#Preview {
    Pro7Part5_Challenge(expenses: Expense_Challenge())
}
