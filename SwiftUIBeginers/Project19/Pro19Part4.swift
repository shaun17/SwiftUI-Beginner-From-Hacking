//
//  Pro19Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/24.
//

import SwiftUI

extension Pro19Part4 {
    @Observable
    class Player {
        var name = "Anonymous"
        var highScore = 0
    }

    struct HighScoreView: View {
        @Environment(Player.self) var player

        var body: some View {
            @Bindable var player =  player
            
            Stepper("High Score: \(player.highScore)", value: $player.highScore)

            Text("Your name: \(player.name)")
        }
    }
}

struct Pro19Part4: View {
    @State var player = Player()
    var body: some View {
        VStack {
            Text("Welcome!")
            TextField("Name", text: $player.name)
            HighScoreView()
        }
        .environment(player)
    }
}

#Preview {
    Pro19Part4()
}
