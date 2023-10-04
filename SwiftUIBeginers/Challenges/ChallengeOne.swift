//
//  ContentView.swift
//  feedmeow
//
//  Created by shaun on 2023/9/14.
//

import SwiftUI

struct ChallengeOne: View {
    @State private var inputunit = 0
    @State private var outputuint = 0
    @State private var inputnumber = ""
    @FocusState private var state: Bool
    
    var units = [
        UnitTemperature.celsius,
        UnitTemperature.kelvin,
        UnitTemperature.fahrenheit
    ]
    
    var result: Measurement<UnitTemperature> {
        let imputamount = Measurement(value: Double(inputnumber) ?? 0, unit: units[inputunit])
        let outresult = imputamount.converted(to: units[outputuint])
        return outresult
    }
    
    func isnumber() -> Bool {
        if Double(inputnumber) == nil {
            return false
        }
        return true
    }

    var meaureformatter: MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.unitStyle = .long
        mf.unitOptions = .providedUnit
        return mf
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Input to convert", text: $inputnumber)
                    .keyboardType(.decimalPad)
                    .focused($state)
                    
                Picker("input unit", selection: $inputunit) {
                    ForEach(0..<units.count, id: \.self) {
                        let a = meaureformatter.string(from: units[$0])
                        Text("\(a)")
                    }
                }
                
                Picker("output unit", selection: $outputuint) {
                    ForEach(0..<units.count, id: \.self) {
                        let a = meaureformatter.string(from: units[$0])
                        Text("\(a)")
                    }
                }
                
                Text("\(meaureformatter.string(from: result))")
            }
            .navigationTitle("Convertion")
            .navigationBarTitleDisplayMode(.inline)
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

struct ChallengeOne_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeOne()
    }
}
