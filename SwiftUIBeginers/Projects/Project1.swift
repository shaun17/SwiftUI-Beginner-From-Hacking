//
//  Project1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/27.
//

import SwiftUI

struct Project1: View {
    @State private var sum = 0.0
    @State private var peoples = 0
    @State private var tipsPercent = 20
    @FocusState private var state: Bool
    
    var totalPerPerson: Double {
        // people is index of arrays
        let peopleCount = Double(peoples + 1)
        let tipSelection = Double(tipsPercent)
        let tipValue = sum / 100 * tipSelection
        let grandTotal = sum + tipValue
        let amountPerPerson = grandTotal / peopleCount
            
        return amountPerPerson
    }
        
    let targetPercents = [5, 10, 15, 20]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $sum, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($state)
                        
            
                    Picker("The number of people", selection: $peoples) {
                        ForEach(1 ..< 21) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("Amount")
                }
            
                Section {
                    Picker("Tips", selection: $tipsPercent) {
                        ForEach(targetPercents, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("choose one tips")
                }
            
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("project one")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("DONE") {
                        state = false

                    }
                }

            }
                
        }
    }
}

struct Project1_Previews: PreviewProvider {
    static var previews: some View {
        Project1()
    }
}
