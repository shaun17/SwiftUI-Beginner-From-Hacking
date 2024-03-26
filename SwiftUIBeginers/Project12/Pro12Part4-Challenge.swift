//
//  Pro12Part4-Challenge.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/26.
//
//
//  Pro7Part5-Challenge.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/19.
//

import SwiftUI
import SwiftData

struct Pro12Part4_Challenge: View {

//    @Bindable var expenses: ExpenseItem_Challenge_Pro12
    
    let types = ["Business", "Personal"]
    
    @State private var name = "Change name"
    @State private var type = "Business"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
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
                    let item = ExpenseItem_Challenge_Pro12(name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    dismiss()
                }
            })

        }
    }
}



#Preview {
    Pro12Part4_Challenge()
        .modelContainer(for: ExpenseItem_Challenge_Pro12.self)
}
