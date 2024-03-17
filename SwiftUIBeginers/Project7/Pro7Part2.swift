//
//  Pro7Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/17.
//
//  @Observable, sheet(), onDelete(),

import SwiftUI

@Observable
class Expense {
    var items = [ExpenseItem]() {
        didSet {
            if let encoder = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoder, forKey: "Items")
            }
        }
    }

    init() {
        if let saveItem = UserDefaults.standard.data(forKey: "Items") {
            if let decodeItem = try? JSONDecoder().decode([ExpenseItem].self, from: saveItem) {
                items = decodeItem
                return
            }
        }
        items = []
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct Pro7Part2: View {
    @State private var exprese = Expense()
    @State private var showingAddExpense = false

    func getNumberByFormatter(_ input: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2 // 最小小数位数
        formatter.maximumFractionDigits = 2 // 最大小数位数
        return formatter.string(from: NSNumber(value: input)) ?? ""
    }

    private var business: [ExpenseItem] {
        exprese.items.filter { $0.type == "Business" }
    }

    private var personal: [ExpenseItem] {
        exprese.items.filter { $0.type == "Personal" }
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Business Expenses") {
                    ForEach(business) { item in
                        HStack {
                            Text(item.name)
                            Text(item.type)
                            if item.amount < 10 {
                                Text("\(item.amount)")
                            } else if item.amount < 100 {
                                Text(item.amount.formatted(.number.precision(.fractionLength(2))))
                            } else {
                                Text(getNumberByFormatter(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItem(at: indexSet, arr: business)
                    })
                }
                Section("Personal Expenses") {
                    ForEach(personal) { item in
                        HStack {
                            Text(item.name)
                            Text(item.type)
                            if item.amount < 10 {
                                Text("\(item.amount)")
                            } else if item.amount < 100 {
                                Text(item.amount.formatted(.number.precision(.fractionLength(2))))
                            } else {
                                Text(getNumberByFormatter(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItem(at: indexSet, arr: personal)
                    })
                }
            }
            .navigationTitle("iExprese")
            .toolbar(content: {
                Button("Add Exprese", systemImage: "plus") {
                    showingAddExpense = true
                }
            })
            .sheet(isPresented: $showingAddExpense, content: {
                Pro7Part3(expenses: exprese)
            })
        }
    }

    func removeItem(at offset: IndexSet, arr: [ExpenseItem]) {
        for index in offset {
            let item = arr[index]
            if let originalIndex = exprese.items.firstIndex(where: { $0.id == item.id }) {
                exprese.items.remove(at: originalIndex)
            }
        }
    }
}

#Preview {
    Pro7Part2()
}
