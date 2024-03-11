//
//  ChallengeUserDetailView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/25.
//

import SwiftUI

struct ChallengeUserDetailView: View {
    let user: ChallengeUser
    var body: some View {
        List{
            Section {
                Text("Registered: \(user.formattedDate)")
                Text("Age: \(user.age)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("Works for: \(user.company)")
            }
        }
    }
}
