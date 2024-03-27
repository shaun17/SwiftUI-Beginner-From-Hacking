//
//  Pro7Part4-Challenge.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/19.
//

import SwiftData
import SwiftUI

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
    @Environment(\.modelContext) var modelContext
    @Query(sort: \ExpenseItem_Challenge_Pro12.name) var exprese: [ExpenseItem_Challenge_Pro12]
    @State private var showingAddExpense = false

    init(sortOrder: [SortDescriptor<ExpenseItem_Challenge_Pro12>]) {
        _exprese = Query(sort: sortOrder)
    }

    var body: some View {
        List {
            ForEach(exprese) { item in
                NavigationLink(destination: Pro12Part4_Challenge_Show(expenses: item)) {
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
            }
            .onDelete(perform: { indexSet in
                deleteItems(at: indexSet)
            })
        }
    }

    func deleteItems(at offsets: IndexSet) {
        // 假设你有一个可以访问的ModelContext实例名为modelContext
        for index in offsets {
            let expenseItem = exprese[index]
            modelContext.delete(expenseItem)
        }

        // 保存更改
        do {
            try modelContext.save()
        } catch {
            print("删除项目时出现问题: \(error)")
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
    @State private var path = [ExpenseItem_Challenge_Pro12]()

    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem_Challenge_Pro12.name),
        SortDescriptor(\ExpenseItem_Challenge_Pro12.amount),
    ]

    var body: some View {
        NavigationStack {
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
        }
        .sheet(isPresented: $showingAddExpense, content: {
            Pro12Part4_Challenge()
        })
    }
}

#Preview {
    Pro12Part3_Challenge()
        .modelContainer(for: ExpenseItem_Challenge_Pro12.self)
}
