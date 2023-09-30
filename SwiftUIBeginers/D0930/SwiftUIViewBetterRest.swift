//
//  SwiftUIViewBetterRest.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/30.
//

import CoreML
import SwiftUI

struct SwiftUIViewBetterRest: View {
    @State private var sleepHour = 8.0
    @State private var coffeeNum = 1
    @State private var wakeup = defaultWakeUpTime
    
    static var defaultWakeUpTime: Date{
        var component = DateComponents(hour: 7, minute: 0)
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isShow = false
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    DatePicker("chose time ", selection: $wakeup, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                }header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepHour.formatted()) hours", value: $sleepHour, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper("\(coffeeNum.formatted()) cap", value: $coffeeNum, in: 1...10)
                    
                }
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $isShow) {
                Button("ok") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let min = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + min), estimatedSleep: sleepHour, coffee: Double(coffeeNum))
   
            let sleepTime = wakeup - prediction.actualSleep
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        isShow = true
    }
}

struct SwiftUIViewBetterRest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewBetterRest()
    }
}
