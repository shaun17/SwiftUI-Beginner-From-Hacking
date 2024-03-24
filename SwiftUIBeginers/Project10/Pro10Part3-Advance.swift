//
//  Pro10Part3-Advance.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/21.
//

import CoreHaptics
import SwiftUI

struct Pro10Part3_Advance: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("tap me", action: complexSuccess)
            .onAppear(perform: {
                perpareHiptics()
            })
    }
    
    func perpareHiptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let instensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [instensity, sharpness], relativeTime: 0)
        events.append(event)

        for i in stride(from: 0, to: 1, by: 0.1){
            let instensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value : Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [instensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1){
            let instensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1-i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value : Float(1-i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [instensity, sharpness], relativeTime: 1+i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

#Preview {
    Pro10Part3_Advance()
}
