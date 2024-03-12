//
//  DemoPart2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/11.
// Form, @State, Picker and more

import SwiftUI

struct DemoPart2: View {
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    @FocusState private var amountIsFocused: Bool

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let needPay = checkAmount + (tipSelection/100 * checkAmount)
        return needPay/peopleCount
    }
    var total: Double {
         (Double(tipPercentage)/100+1)*checkAmount
    }

    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        NavigationStack {
            Form(content: {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 10) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

              
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("Total:"){
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(total == checkAmount ? .red : .black)
                }

            })
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("DONE") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    DemoPart2()
}
