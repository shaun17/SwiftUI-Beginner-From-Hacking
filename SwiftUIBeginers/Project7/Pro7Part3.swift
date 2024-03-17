//
//  Pro7Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/17.
//

import SwiftUI

struct Pro7Part3: View {
    
    var expenses: Expense
    
    let types = ["Business", "Personal"]
    
    @State private var name = ""
    @State private var type = "Business"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        NavigationStack{
            Form{
                TextField("input your name", text: $name)
                Picker("select your type", selection: $type) {
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("input your Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar(content: {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            })

        }
    }
}

#Preview {
    Pro7Part3(expenses: Expense())
}
