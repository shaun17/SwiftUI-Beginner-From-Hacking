//
//  Pro7Part4-Challenge.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/19.
//

import SwiftData
import SwiftUI

// @Model
// class Expense_Challenge_Pro12: ObservableObject, Hashable {
//    static func == (lhs: Expense_Challenge_Pro12, rhs: Expense_Challenge_Pro12) -> Bool {
//        lhs.items == rhs.items
//    }
//
//    var items = [ExpenseItem_Challenge_Pro12]() {
//        didSet {
//            if let encoder = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.setValue(encoder, forKey: "Items")
//            }
//        }
//    }
//
//    init() {
//        if let saveItem = UserDefaults.standard.data(forKey: "Items") {
//            if let decodeItem = try? JSONDecoder().decode([ExpenseItem_Challenge_Pro12].self, from: saveItem) {
//                items = decodeItem
//                return
//            }
//        }
//        items = []
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(items)
//    }
// }

@Model
class ExpenseItem_Challenge_Pro12: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}

struct Pro12Part3_ShoView: View {
    @Query(sort: \ExpenseItem_Challenge_Pro12.name) var exprese: [ExpenseItem_Challenge_Pro12]

    init(sortOrder: [SortDescriptor<ExpenseItem_Challenge_Pro12>]) {
        _exprese = Query(sort: sortOrder)
    }

    var body: some View {
        List {
            ForEach(exprese) { item in
                NavigationLink(value: item) {
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
//                        .navigationDestination(for: ExpenseItem_Challenge_Pro12.self) { item in
                ////                            Pro12Part4_Challenge()
//                        }
            }
            .onDelete(perform: { _ in
//                        removeItem(at: indexSet, arr: business)
            })
        }
    }
    
    func getNumberByFormatter(_ input: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2 // 最小小数位数
        formatter.maximumFractionDigits = 2 // 最大小数位数
        return formatter.string(from: NSNumber(value: input)) ?? ""
    }

   
}

struct Pro12Part3_Challenge: View {
    @State private var showingAddExpense = false

    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem_Challenge_Pro12.name),
        SortDescriptor(\ExpenseItem_Challenge_Pro12.amount),
    ]

   var body: some View {
        NavigationStack {
            NavigationLink(destination: Pro12Part4_Challenge(), isActive: $showingAddExpense) {}
                .hidden()
            Pro12Part3_ShoView(sortOrder: sortOrder)
                .navigationTitle("iExprese")
                .toolbar(content: {
                    Button("Add Exprese", systemImage: "plus") {
                        showingAddExpense = true
                    }

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([SortDescriptor(\ExpenseItem_Challenge_Pro12.name),
                                      SortDescriptor(\ExpenseItem_Challenge_Pro12.amount)])
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem_Challenge_Pro12.amount),
                                    SortDescriptor(\ExpenseItem_Challenge_Pro12.name),
                                ])
                        }
                    }

                })

//
//            .sheet(isPresented: $showingAddExpense, content: {
//                Pro7Part3(expenses: exprese)
//            })
        }
    }

//    func removeItem(at offset: IndexSet, arr: [ExpenseItem_Challenge_Pro12]) {
//        for index in offset {
//            let item = arr[index]
//            if let originalIndex = exprese.items.firstIndex(where: { $0.id == item.id }) {
//                exprese.items.remove(at: originalIndex)
//            }
//        }
//    }
}

#Preview {
    Pro12Part3_Challenge()
        .modelContainer(for: ExpenseItem_Challenge_Pro12.self)
}
