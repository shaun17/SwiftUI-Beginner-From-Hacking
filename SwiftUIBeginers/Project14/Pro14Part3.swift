//
//  Pro14Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/29.
//

import LocalAuthentication
import SwiftUI

struct Pro14Part3: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, _ in

                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {}
    }
}

#Preview {
    Pro14Part3()
}
