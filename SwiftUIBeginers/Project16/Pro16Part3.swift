//
//  Pro16Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/1.
//

import SwiftUI
import UserNotifications


struct Pro16Part3: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Send message", systemImage: "cloud") {
                        print("Hi")
                    }
                }
                .tint(.blue)
                .swipeActions {
                    Button("Send message", systemImage: "cloud") {
                        print("Hi")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("pin")
                    }
                    .tint(.orange)
                }
        }

        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
                    success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

#Preview {
    Pro16Part3()
}
