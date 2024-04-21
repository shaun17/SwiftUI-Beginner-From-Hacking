//
//  Pro4Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/13.
//

import SwiftUI

struct Pro4Part1: View {
    @State private var sleepAmount = 3.0
    @State private var wakeUp = Date.now
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4 ... 12, step: 0.25)
        DatePicker("Please enter a date", selection: $wakeUp)
        DatePicker("", selection: $wakeUp)
        DatePicker("context is gone", selection: $wakeUp).labelsHidden()
        DatePicker("", selection: $wakeUp, in: ...Date.now, displayedComponents: .date)
            .labelsHidden()

        Text(Date.now, format: .dateTime.day().month().year())
        Text(Date.now, format: .dateTime.hour().minute().second())
    }

    func method() {
        var componets = DateComponents()
        componets.hour = 8
        componets.minute = 0
        let date = Calendar.current.date(from: componets) ?? .now
        print(date)
    }
}

#Preview {
    Pro4Part1()
}
