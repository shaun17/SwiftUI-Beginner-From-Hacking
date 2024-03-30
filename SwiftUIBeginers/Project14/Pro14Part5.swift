//
//  Pro14Part5.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/30.
//

import CoreLocation
import MapKit
import SwiftUI
import LocalAuthentication

extension Pro14Part4 {
    @Observable
    class ViewModel {
        private(set) var locations: [LocationPro14]
        var selectedPlace: LocationPro14?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        var isUnlocked = false

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([LocationPro14].self, from: data)
            } catch {
                locations = []
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = LocationPro14(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }

        func update(location: LocationPro14) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            } else {}
        }
    }
}
