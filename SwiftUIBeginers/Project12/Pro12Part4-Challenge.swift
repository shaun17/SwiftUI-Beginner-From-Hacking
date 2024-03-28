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

import SwiftData
import SwiftUI

struct Pro12Part4_Challenge: View {

    let types = ["Business", "Personal"]

    @State private var name = "Change name"
    @State private var type = "Business"
    @State private var amount = 0.0

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            Form {
//                TextField("input your name", text: $name)
                Picker("select your type", selection: $type) {
                    ForEach(types, id: \.self) {
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

struct Pro12Part4_Challenge_Show: View {
    @Bindable var expenses: ExpenseItem_Challenge_Pro12

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
//                TextField("input your name", text: $name)
                Picker("select your type", selection: $expenses.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("input your Amount", value: $expenses.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($expenses.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let modelContainer = try ModelContainer(for: ExpenseItem_Challenge_Pro12.self, configurations: config)
//        let express = ExpenseItem_Challenge_Pro12(name: "name", type: "Personal", amount: 1.1)
//        return Pro12Part4_Challenge_Show(expenses: express)
//            .modelContainer(modelContainer)
//    } catch {
//        return Text("")
//    }
//}
