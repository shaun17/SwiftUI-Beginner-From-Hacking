//
//  SwiftUIView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/11.
//

import SwiftUI

struct Challenge1: View {
    @State var input = ""
    @State var inUnit: Int = 0
    @State var convertUnit: Int = 0
    @FocusState private var amountIsFocused: Bool

    var units = [
        UnitTemperature.celsius,
        UnitTemperature.kelvin,
        UnitTemperature.fahrenheit
    ]
    
    var meaturement: Measurement<UnitTemperature> {
        Measurement(value: Double(input) ?? 0, unit: units[inUnit])
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Section {
                        TextField("请输入", text: $input)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("单位", selection: $inUnit) {
                            ForEach(0..<units.count, id: \.self) {
                                Text("\(units[$0].symbol)")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button("->转换->") {}
                        .disabled(true)
                        .frame(maxWidth: .infinity)
                    
                    Section {
                        Picker("单位", selection: $convertUnit) {
                            ForEach(0..<units.count, id: \.self) {
                                Text("\(units[$0].symbol)")
                            }
                        }
                        Text("\(meaturement.converted(to: units[convertUnit]).value.formatted())")
                    }
                    .frame(maxWidth: .infinity)
                }
            }
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
    Challenge1()
}
